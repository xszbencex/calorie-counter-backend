package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.PersonalDataDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.WeightChangeDTO;
import inf.unideb.caloriecounterbackend.entity.PersonalData;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.exception.ApplicationException;
import inf.unideb.caloriecounterbackend.repository.PersonalDataRepository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;

@Service
@NoArgsConstructor
public class PersonalDataService extends BaseService<PersonalDataDTO, PersonalData> {

    private PersonalDataRepository personalDataRepository;

    private WeightChangeService weightChangeService;

    @Autowired
    public PersonalDataService(final PersonalDataRepository personalDataRepository, final WeightChangeService weightChangeService) {
        super(PersonalDataDTO.class, PersonalData.class);
        this.personalDataRepository = personalDataRepository;
        this.weightChangeService = weightChangeService;
    }

    public Result<PersonalDataDTO> createPersonalData(final PersonalDataDTO personalDataDTO) {
        final PersonalData personalData = super.mapFromDTO(personalDataDTO);
        personalData.setId(null);
        personalData.setUserId(super.getUserUuid());

        final WeightChangeDTO weightChangeDTO = new WeightChangeDTO();
        weightChangeDTO.setWeight(personalData.getWeight());
        weightChangeDTO.setSetDate(LocalDate.now());
        this.weightChangeService.createWeightChange(weightChangeDTO);

        return new Result<>(super.mapToDTO(this.personalDataRepository.save(personalData)));
    }

    public Result<List<PersonalDataDTO>> getAllPersonalData() {
        return new Result<>(super.mapEntityListToDTOList(this.personalDataRepository.findAll()));
    }

    public Result<PersonalDataDTO> getPersonalDataById(final String personalDataId) {
        return this.personalDataRepository.findById(personalDataId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(PersonalData.class.getSimpleName(), personalDataId)));
    }

    public Result<PersonalDataDTO> getPersonalDataByUserId(final String userId) {
        return this.personalDataRepository.findPersonalDataByUserId(userId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(PersonalData.class.getSimpleName(), userId)));
    }

    public Result<PersonalDataDTO> updatePersonalData(final PersonalDataDTO personalDataDTO, final String personalDataId) {
        return this.personalDataRepository.findById(personalDataId)
                .map(updatedPersonalData -> {
                    if (!updatedPersonalData.getUserId().equals(super.getUserUuid())) {
                        throw new ApplicationException(ApplicationError.notMatchingUserId());
                    }

                    if (!personalDataDTO.getWeight().equals(updatedPersonalData.getWeight())) {
                        final WeightChangeDTO weightChangeDTO = new WeightChangeDTO();
                        weightChangeDTO.setWeight(personalDataDTO.getWeight());
                        weightChangeDTO.setSetDate(LocalDate.now());
                        this.weightChangeService.createWeightChange(weightChangeDTO);
                    }

                    personalDataDTO.setUserId(updatedPersonalData.getUserId());
                    updatedPersonalData = super.mapFromDTO(personalDataDTO);
                    updatedPersonalData.setId(personalDataId);


                    return super.mapToDTO(this.personalDataRepository.save(updatedPersonalData));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(PersonalData.class.getSimpleName(), personalDataId)));
    }

    public Result<Void> deletePersonalData(final String personalDataId) {
        if (this.personalDataRepository.findById(personalDataId).orElseThrow().getUserId().equals(super.getUserUuid())) {
            this.personalDataRepository.deleteById(personalDataId);
            return Result.ok();
        } else {
            return Result.error(ApplicationError.notMatchingUserId());
        }
    }

}
