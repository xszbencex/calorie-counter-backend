package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.NutritionDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.response.NutritionSumResponse;
import inf.unideb.caloriecounterbackend.entity.Nutrition;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.repository.NutritionRepository;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAccessor;
import java.util.Date;
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

    public Result<NutritionSumResponse> getNutritionSumByDate(final Instant nutritionDate) {
        final List<Nutrition> nutritionList = this.nutritionRepository.findAllByNutritionDate(Date.from(nutritionDate));
        final NutritionSumResponse response = new NutritionSumResponse();
        response.setCarbohydrateSum(nutritionList.stream().mapToInt(Nutrition::getCarbohydrate).sum());
        response.setProteinSum(nutritionList.stream().mapToInt(Nutrition::getProtein).sum());
        response.setFatSum(nutritionList.stream().mapToInt(Nutrition::getFat).sum());
        response.setCalorieSum(nutritionList.stream().mapToInt(Nutrition::getCalorie).sum());
        return new Result<>(response);
    }

    public Result<NutritionDTO> updateNutrition(final NutritionDTO nutritionDTO, final String nutritionId) {
        return this.nutritionRepository.findById(nutritionId)
                .map(updatedNutrition -> {
                    updatedNutrition = super.mapFromDTO(nutritionDTO);
                    updatedNutrition.setId(nutritionId);
                    return super.mapToDTO(this.nutritionRepository.save(updatedNutrition));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Nutrition.class.getSimpleName(), nutritionId)));
    }

    public Result<Void> deleteNutrition(final String nutritionId) {
        this.nutritionRepository.deleteById(nutritionId);
        return Result.ok();
    }

}
