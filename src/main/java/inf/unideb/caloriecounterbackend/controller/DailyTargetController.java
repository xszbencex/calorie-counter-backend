package inf.unideb.caloriecounterbackend.controller;

import inf.unideb.caloriecounterbackend.dto.DailyTargetDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.service.DailyTargetService;

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
@RequestMapping(path = "/dailyTarget")
public class DailyTargetController {

    private final DailyTargetService dailyTargetService;

    @Autowired
    public DailyTargetController(final DailyTargetService dailyTargetService) {
        this.dailyTargetService = dailyTargetService;
    }

    @GetMapping
    public Result<List<DailyTargetDTO>> getAllDailyTarget() {
        return this.dailyTargetService.getAllDailyTarget();
    }

    @GetMapping("/user/{userId}")
    public Result<DailyTargetDTO> getDailyTargetByUserId(@PathVariable final String userId) {
        return this.dailyTargetService.getDailyTargetByUserId(userId);
    }

    @GetMapping("/{dailyTargetId}")
    public Result<DailyTargetDTO> getDailyTargetById(
            @PathVariable final String dailyTargetId) {
        return this.dailyTargetService.getDailyTargetById(dailyTargetId);
    }

    @PostMapping
    public Result<DailyTargetDTO> createDailyTarget(
            @Valid @RequestBody final DailyTargetDTO dailyTargetDTO) {
        return this.dailyTargetService.createDailyTarget(dailyTargetDTO);
    }

    @PutMapping("/{dailyTargetId}")
    public Result<DailyTargetDTO> updateDailyTarget(
            @Valid @RequestBody final DailyTargetDTO dailyTargetDTO,
            @PathVariable final String dailyTargetId) {
        return this.dailyTargetService.updateDailyTarget(dailyTargetDTO, dailyTargetId);
    }

    @DeleteMapping("/{dailyTargetId}")
    public Result<Void> deleteDailyTarget(
            @PathVariable final String dailyTargetId) {
        return this.dailyTargetService.deleteDailyTarget(dailyTargetId);
    }

}
