package inf.unideb.caloriecounterbackend.controller;

import inf.unideb.caloriecounterbackend.dto.NutritionDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.service.NutritionService;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/nutrition")
public class NutritionController {

    private final NutritionService nutritionService;

    @Autowired
    public NutritionController(final NutritionService nutritionService) {
        this.nutritionService = nutritionService;
    }

    @GetMapping
    public Result<List<NutritionDTO>> getAllNutrition() {
        return this.nutritionService.getAllNutrition();
    }

    @GetMapping("/{nutritionId}")
    public Result<NutritionDTO> getNutritionById(
            @PathVariable final String nutritionId) {
        return this.nutritionService.getNutritionById(nutritionId);
    }

    @PostMapping("/create")
    public Result<NutritionDTO> createNutrition(
            @Valid @RequestBody final NutritionDTO nutritionDTO) {
        return this.nutritionService.createNutrition(nutritionDTO);
    }

    @PutMapping("/{nutritionId}")
    public Result<NutritionDTO> updateNutrition(
            @Valid @RequestBody final NutritionDTO nutritionDTO,
            @PathVariable final String nutritionId) {
        return this.nutritionService.updateNutrition(nutritionDTO, nutritionId);
    }

    @DeleteMapping("/{nutritionId}")
    public Result<Void> deleteNutrition(
            @PathVariable final String nutritionId) {
        return this.nutritionService.deleteNutrition(nutritionId);
    }

}