package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.NutritionDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.enums.ProductType;
import inf.unideb.caloriecounterbackend.dto.response.NutritionSumResponse;
import inf.unideb.caloriecounterbackend.entity.Nutrition;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.exception.ApplicationException;
import inf.unideb.caloriecounterbackend.repository.NutritionRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;

@Service
@NoArgsConstructor
public class NutritionService extends BaseService<NutritionDTO, Nutrition> {

    private NutritionRepository nutritionRepository;

    @Autowired
    public NutritionService(final NutritionRepository nutritionRepository) {
        super(NutritionDTO.class, Nutrition.class);
        this.nutritionRepository = nutritionRepository;
    }

    public Result<NutritionDTO> createNutrition(final NutritionDTO nutritionDTO) {
        final Nutrition nutrition = super.mapFromDTO(nutritionDTO);
        nutrition.setId(null);
        nutrition.setUserId(super.getUserUuid());
        return new Result<>(super.mapToDTO(this.nutritionRepository.save(nutrition)));
    }

    public Result<List<NutritionDTO>> getAllNutrition() {
        return new Result<>(super.mapEntityListToDTOList(this.nutritionRepository.findAll()));
    }

    public Result<List<NutritionDTO>> getAllNutritionByUserId(final String userId) {
        return new Result<>(super.mapEntityListToDTOList(this.nutritionRepository.findAllByUserId(userId)));
    }

    public Result<NutritionDTO> getNutritionById(final String nutritionId) {
        return this.nutritionRepository.findById(nutritionId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Nutrition.class.getSimpleName(), nutritionId)));
    }

    public Result<NutritionSumResponse> getNutritionSumByDate(final LocalDate nutritionDate) {
        final List<Nutrition> nutritionList = this.nutritionRepository.findAllByNutritionDateAndUserId(nutritionDate, super.getUserUuid());
        return new Result<>(this.constructNutritionSumResponse(nutritionDate, nutritionList));
    }

    public Result<List<NutritionSumResponse>> getNutritionSumByMonth(final Integer year, final Integer month) {
        LocalDate start = LocalDate.of(year, month, 1);
        LocalDate end = start.plusMonths(1).withDayOfMonth(1);
        final List<NutritionSumResponse> sumList = new ArrayList<>();
        start.datesUntil(end).forEach(localDate -> sumList.add(
                this.getNutritionSumByDate(localDate).getDataOrThrow())
        );
        return new Result<>(sumList);
    }

    public Result<NutritionDTO> updateNutrition(final NutritionDTO nutritionDTO, final String nutritionId) {
        return this.nutritionRepository.findById(nutritionId)
                .map(updatedNutrition -> {
                    if (!updatedNutrition.getUserId().equals(super.getUserUuid())) {
                        throw new ApplicationException(ApplicationError.notMatchingUserId());
                    }
                    nutritionDTO.setUserId(updatedNutrition.getUserId());
                    updatedNutrition = super.mapFromDTO(nutritionDTO);
                    updatedNutrition.setId(nutritionId);
                    return super.mapToDTO(this.nutritionRepository.save(updatedNutrition));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Nutrition.class.getSimpleName(), nutritionId)));
    }

    public Result<Void> deleteNutrition(final String nutritionId) {
        if (this.nutritionRepository.findById(nutritionId).orElseThrow().getUserId().equals(super.getUserUuid())) {
            this.nutritionRepository.deleteById(nutritionId);
            return Result.ok();
        } else {
            return Result.error(ApplicationError.notMatchingUserId());
        }
    }

    private NutritionSumResponse constructNutritionSumResponse(final LocalDate nutritionDate, final List<Nutrition> nutritionList) {
        final NutritionSumResponse response = new NutritionSumResponse();
        response.setNutritionDate(nutritionDate);
        response.setCarbohydrateSum((float) nutritionList.stream().mapToDouble(Nutrition::getCarbohydrate).sum());
        response.setProteinSum((float) nutritionList.stream().mapToDouble(Nutrition::getProtein).sum());
        response.setFatSum((float) nutritionList.stream().mapToDouble(Nutrition::getFat).sum());
        response.setCalorieSum(nutritionList.stream().mapToInt(Nutrition::getCalorie).sum());
        response.setWaterSum((float) nutritionList.stream()
                .filter(nutrition -> nutrition.getProduct() != null && nutrition.getProduct().getProductType() == ProductType.WATER)
                .mapToDouble(value -> value.getQuantity() / 1000f).sum());
        return response;
    }
}
