package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.NutritionDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.entity.Nutrition;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.repository.NutritionRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NutritionService extends BaseService<NutritionDTO, Nutrition> {

    private final NutritionRepository nutritionRepository;

    @Autowired
    public NutritionService(NutritionRepository nutritionRepository) {
        super(NutritionDTO.class, Nutrition.class);
        this.nutritionRepository = nutritionRepository;
    }

    public Result<NutritionDTO> createNutrition(final NutritionDTO nutritionDTO) {
        final Nutrition nutrition = super.mapFromDTO(nutritionDTO);
        return new Result<>(super.mapToDTO(this.nutritionRepository.save(nutrition)));
    }

    public Result<List<NutritionDTO>> getAllNutrition() {
        return new Result<>(super.mapEntityListToDTOList(this.nutritionRepository.findAll()));
    }

    public Result<NutritionDTO> getNutritionById(final String nutritionId) {
        return this.nutritionRepository.findById(nutritionId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Nutrition.class.getSimpleName(), nutritionId)));
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
