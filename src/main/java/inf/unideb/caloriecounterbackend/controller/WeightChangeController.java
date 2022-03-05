package inf.unideb.caloriecounterbackend.controller;

import inf.unideb.caloriecounterbackend.dto.WeightChangeDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.service.WeightChangeService;

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
@RequestMapping(path = "/weightChange")
public class WeightChangeController {

    private final WeightChangeService weightChangeService;

    @Autowired
    public WeightChangeController(final WeightChangeService weightChangeService) {
        this.weightChangeService = weightChangeService;
    }

    @GetMapping("user/{userId}")
    public Result<List<WeightChangeDTO>> getAllWeightChangeByUserId(@PathVariable final String userId) {
        return this.weightChangeService.getAllWeightChangeByUserId(userId);
    }

    @GetMapping("/{weightChangeId}")
    public Result<WeightChangeDTO> getWeightChangeById(
            @PathVariable final String weightChangeId) {
        return this.weightChangeService.getWeightChangeById(weightChangeId);
    }

    @PostMapping
    public Result<WeightChangeDTO> createWeightChange(
            @Valid @RequestBody final WeightChangeDTO weightChangeDTO) {
        return this.weightChangeService.createWeightChange(weightChangeDTO);
    }

    @PutMapping("/{weightChangeId}")
    public Result<WeightChangeDTO> updateWeightChange(
            @Valid @RequestBody final WeightChangeDTO weightChangeDTO,
            @PathVariable final String weightChangeId) {
        return this.weightChangeService.updateWeightChange(weightChangeDTO, weightChangeId);
    }

    @DeleteMapping("/{weightChangeId}")
    public Result<Void> deleteWeightChange(
            @PathVariable final String weightChangeId) {
        return this.weightChangeService.deleteWeightChange(weightChangeId);
    }
}
