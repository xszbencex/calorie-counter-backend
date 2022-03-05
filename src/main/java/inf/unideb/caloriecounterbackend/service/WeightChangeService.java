package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.WeightChangeDTO;
import inf.unideb.caloriecounterbackend.entity.WeightChange;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.exception.ApplicationException;
import inf.unideb.caloriecounterbackend.repository.WeightChangeRepository;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;

@Service
@NoArgsConstructor
public class WeightChangeService extends BaseService<WeightChangeDTO, WeightChange> {

    private WeightChangeRepository weightChangeRepository;

    @Autowired
    public WeightChangeService(final WeightChangeRepository weightChangeRepository) {
        super(WeightChangeDTO.class, WeightChange.class);
        this.weightChangeRepository = weightChangeRepository;
    }

    public Result<WeightChangeDTO> createWeightChange(final WeightChangeDTO weightChangeDTO) {
        final WeightChange weightChange = super.mapFromDTO(weightChangeDTO);
        weightChange.setId(null);
        weightChange.setUserId(super.getUserUuid());
        return new Result<>(super.mapToDTO(this.weightChangeRepository.save(weightChange)));
    }

    public Result<WeightChangeDTO> getWeightChangeById(final String weightChangeId) {
        return this.weightChangeRepository.findById(weightChangeId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(WeightChange.class.getSimpleName(), weightChangeId)));
    }

    public Result<List<WeightChangeDTO>> getAllWeightChangeByUserId(final String userId) {
        return new Result<>(super.mapEntityListToDTOList(this.weightChangeRepository.findAllByUserId(userId)));
    }

    public WeightChange getWeightChangeEntityById(final String weightChangeId) {
        final Optional<WeightChange> weightChange = this.weightChangeRepository.findById(weightChangeId);
        if (weightChange.isEmpty()) {
            throw new ApplicationException(ApplicationError.entityNotFound(WeightChange.class.getSimpleName(), weightChangeId));
        }
        return weightChange.get();
    }

    public Result<WeightChangeDTO> updateWeightChange(final WeightChangeDTO weightChangeDTO, final String weightChangeId) {
        return this.weightChangeRepository.findById(weightChangeId)
                .map(updatedWeightChange -> {
                    if (!updatedWeightChange.getUserId().equals(super.getUserUuid())) {
                        throw new ApplicationException(ApplicationError.notMatchingUserId());
                    }
                    weightChangeDTO.setUserId(updatedWeightChange.getUserId());
                    updatedWeightChange = super.mapFromDTO(weightChangeDTO);
                    updatedWeightChange.setId(weightChangeId);
                    return super.mapToDTO(this.weightChangeRepository.save(updatedWeightChange));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(WeightChange.class.getSimpleName(), weightChangeId)));
    }

    public Result<Void> deleteWeightChange(final String weightChangeId) {
        if (this.weightChangeRepository.findById(weightChangeId).orElseThrow().getUserId().equals(super.getUserUuid())) {
            this.weightChangeRepository.deleteById(weightChangeId);
            return Result.ok();
        } else {
            return Result.error(ApplicationError.notMatchingUserId());
        }
    }
}
