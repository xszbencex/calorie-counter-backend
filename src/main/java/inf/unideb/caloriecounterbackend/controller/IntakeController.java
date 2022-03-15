package inf.unideb.caloriecounterbackend.controller;

import inf.unideb.caloriecounterbackend.dto.IntakeDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.request.WaterIntakeRequest;
import inf.unideb.caloriecounterbackend.dto.response.IntakeSumResponse;
import inf.unideb.caloriecounterbackend.service.IntakeService;

import java.time.LocalDate;
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
@RequestMapping(path = "/intake")
public class IntakeController {

    private final IntakeService intakeService;

    @Autowired
    public IntakeController(final IntakeService intakeService) {
        this.intakeService = intakeService;
    }

    @GetMapping
    public Result<List<IntakeDTO>> getAllIntake() {
        return this.intakeService.getAllIntake();
    }

    @GetMapping("user/{userId}")
    public Result<List<IntakeDTO>> getAllIntakeByUserId(@PathVariable final String userId) {
        return this.intakeService.getAllIntakeByUserId(userId);
    }

    @GetMapping("/{intakeId}")
    public Result<IntakeDTO> getIntakeById(
            @PathVariable final String intakeId) {
        return this.intakeService.getIntakeById(intakeId);
    }

    @GetMapping("/date/{intakeDate}")
    public Result<List<IntakeDTO>> getAllIntakeByDateAndUserId(
            @PathVariable final LocalDate intakeDate) {
        return this.intakeService.getAllIntakeByDateAndUserId(intakeDate);
    }

    @GetMapping("/sum/{intakeDate}")
    public Result<IntakeSumResponse> getIntakeSumByDate(
            @PathVariable final LocalDate intakeDate) {
        return this.intakeService.getIntakeSumByDate(intakeDate);
    }

    @GetMapping("/sum/year/{year}/month/{month}")
    public Result<List<IntakeSumResponse>> getIntakeSumByMonth(
            @PathVariable final Integer year,
            @PathVariable final Integer month) {
        return this.intakeService.getIntakeSumByMonth(year, month);
    }

    @PostMapping
    public Result<IntakeDTO> createIntake(
            @Valid @RequestBody final IntakeDTO intakeDTO) {
        return this.intakeService.createIntake(intakeDTO);
    }

    @PostMapping("/water")
    public Result<IntakeDTO> createWaterIntake(
            @Valid @RequestBody final WaterIntakeRequest waterIntakeRequest) {
        return this.intakeService.createWaterIntake(waterIntakeRequest);
    }

    @PutMapping("/{intakeId}")
    public Result<IntakeDTO> updateIntake(
            @Valid @RequestBody final IntakeDTO intakeDTO,
            @PathVariable final String intakeId) {
        return this.intakeService.updateIntake(intakeDTO, intakeId);
    }

    @DeleteMapping("/{intakeId}")
    public Result<Void> deleteIntake(
            @PathVariable final String intakeId) {
        return this.intakeService.deleteIntake(intakeId);
    }

}
