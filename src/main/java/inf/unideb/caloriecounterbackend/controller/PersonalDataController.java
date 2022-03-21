package inf.unideb.caloriecounterbackend.controller;

import inf.unideb.caloriecounterbackend.dto.PersonalDataDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.service.PersonalDataService;

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
@RequestMapping(path = "/personalData")
public class PersonalDataController {

    private final PersonalDataService personalDataService;

    @Autowired
    public PersonalDataController(final PersonalDataService personalDataService) {
        this.personalDataService = personalDataService;
    }

    @GetMapping
    public Result<List<PersonalDataDTO>> getAllPersonalData() {
        return this.personalDataService.getAllPersonalData();
    }

    @GetMapping("/{personalDataId}")
    public Result<PersonalDataDTO> getPersonalDataById(
            @PathVariable final String personalDataId) {
        return this.personalDataService.getPersonalDataById(personalDataId);
    }

    @GetMapping("/user/{userId}")
    public Result<PersonalDataDTO> getPersonalDataByUserId(
            @PathVariable final String userId) {
        return this.personalDataService.getPersonalDataByUserId(userId);
    }

    @PostMapping
    public Result<PersonalDataDTO> createPersonalData(
            @Valid @RequestBody final PersonalDataDTO personalDataDTO) {
        return this.personalDataService.createPersonalData(personalDataDTO);
    }

    @PutMapping("/{personalDataId}")
    public Result<PersonalDataDTO> updatePersonalData(
            @Valid @RequestBody final PersonalDataDTO personalDataDTO,
            @PathVariable final String personalDataId) {
        return this.personalDataService.updatePersonalData(personalDataDTO, personalDataId);
    }

    @DeleteMapping("/{personalDataId}")
    public Result<Void> deletePersonalData(
            @PathVariable final String personalDataId) {
        return this.personalDataService.deletePersonalData(personalDataId);
    }

}
