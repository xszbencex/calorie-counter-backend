package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.DailyTargetDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.entity.DailyTarget;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.exception.ApplicationException;
import inf.unideb.caloriecounterbackend.repository.DailyTargetRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;

@Service
@NoArgsConstructor
public class DailyTargetService extends BaseService<DailyTargetDTO, DailyTarget> {

    private DailyTargetRepository dailyTargetRepository;

    @Autowired
    public DailyTargetService(final DailyTargetRepository dailyTargetRepository) {
        super(DailyTargetDTO.class, DailyTarget.class);
        this.dailyTargetRepository = dailyTargetRepository;
    }

    public Result<DailyTargetDTO> createDailyTarget(final DailyTargetDTO dailyTargetDTO) {
        final DailyTarget dailyTarget = super.mapFromDTO(dailyTargetDTO);
        dailyTarget.setId(null);
        dailyTarget.setUserId(super.getUserUuid());
        return new Result<>(super.mapToDTO(this.dailyTargetRepository.save(dailyTarget)));
    }

    public Result<List<DailyTargetDTO>> getAllDailyTarget() {
        return new Result<>(super.mapEntityListToDTOList(this.dailyTargetRepository.findAll()));
    }

    public Result<DailyTargetDTO> getDailyTargetById(final String dailyTargetId) {
        return this.dailyTargetRepository.findById(dailyTargetId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(DailyTarget.class.getSimpleName(), dailyTargetId)));
    }

    public Result<DailyTargetDTO> getDailyTargetByUserId(final String userId) {
        return this.dailyTargetRepository.findByUserId(userId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(DailyTarget.class.getSimpleName(), userId)));
    }

    public Result<DailyTargetDTO> updateDailyTarget(final DailyTargetDTO dailyTargetDTO, final String dailyTargetId) {
        return this.dailyTargetRepository.findById(dailyTargetId)
                .map(updatedDailyTarget -> {
                    if (!updatedDailyTarget.getUserId().equals(super.getUserUuid())) {
                        throw new ApplicationException(ApplicationError.notMatchingUserId());
                    }

                    dailyTargetDTO.setUserId(updatedDailyTarget.getUserId());
                    updatedDailyTarget = super.mapFromDTO(dailyTargetDTO);
                    updatedDailyTarget.setId(dailyTargetId);

                    return super.mapToDTO(this.dailyTargetRepository.save(updatedDailyTarget));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(DailyTarget.class.getSimpleName(), dailyTargetId)));
    }

    public Result<Void> deleteDailyTarget(final String dailyTargetId) {
        if (this.dailyTargetRepository.findById(dailyTargetId).orElseThrow().getUserId().equals(super.getUserUuid())) {
            this.dailyTargetRepository.deleteById(dailyTargetId);
            return Result.ok();
        } else {
            return Result.error(ApplicationError.notMatchingUserId());
        }
    }

}
