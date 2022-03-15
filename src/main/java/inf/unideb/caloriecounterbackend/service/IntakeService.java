package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.IntakeDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.enums.ProductType;
import inf.unideb.caloriecounterbackend.dto.request.WaterIntakeRequest;
import inf.unideb.caloriecounterbackend.dto.response.IntakeSumResponse;
import inf.unideb.caloriecounterbackend.entity.Intake;
import inf.unideb.caloriecounterbackend.entity.Product;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.exception.ApplicationException;
import inf.unideb.caloriecounterbackend.repository.IntakeRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;

@Service
@NoArgsConstructor
public class IntakeService extends BaseService<IntakeDTO, Intake> {

    private IntakeRepository intakeRepository;

    @Autowired
    public IntakeService(final IntakeRepository intakeRepository) {
        super(IntakeDTO.class, Intake.class);
        this.intakeRepository = intakeRepository;
    }

    public Result<IntakeDTO> createIntake(final IntakeDTO intakeDTO) {
        final Intake intake = super.mapFromDTO(intakeDTO);
        intake.setId(null);
        intake.setUserId(super.getUserUuid());
        return new Result<>(super.mapToDTO(this.intakeRepository.save(intake)));
    }

    public Result<IntakeDTO> createWaterIntake(final WaterIntakeRequest waterIntakeRequest) {
        final Product water = super.getProductService().getWaterProductEntity();
        final Intake intake = new Intake();
        intake.setProduct(water);
        intake.setIntakeDate(waterIntakeRequest.getIntakeDate());
        intake.setQuantity(waterIntakeRequest.getQuantity());
        intake.setComment(waterIntakeRequest.getComment());
        intake.setId(null);
        intake.setUserId(super.getUserUuid());
        intake.setCalorie((short) 0);
        intake.setCarbohydrate(0f);
        intake.setProtein(0f);
        intake.setFat(0f);
        return new Result<>(super.mapToDTO(this.intakeRepository.save(intake)));
    }

    public Result<List<IntakeDTO>> getAllIntake() {
        return new Result<>(super.mapEntityListToDTOList(this.intakeRepository.findAll()));
    }

    public Result<List<IntakeDTO>> getAllIntakeByUserId(final String userId) {
        return new Result<>(super.mapEntityListToDTOList(this.intakeRepository.findAllByUserIdOrderByIntakeDateDesc(userId)));
    }

    public Result<List<IntakeDTO>> getAllIntakeByDateAndUserId(final LocalDate intakeDate) {
        return new Result<>(super.mapEntityListToDTOList(
                this.intakeRepository.findAllByIntakeDateGreaterThanEqualAndIntakeDateLessThanAndUserId(
                        intakeDate.atStartOfDay(), intakeDate.plusDays(1).atStartOfDay(), super.getUserUuid()))
        );
    }

    public Result<IntakeDTO> getIntakeById(final String intakeId) {
        return this.intakeRepository.findById(intakeId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Intake.class.getSimpleName(), intakeId)));
    }

    public Result<IntakeSumResponse> getIntakeSumByDate(final LocalDate intakeDate) {
        final List<Intake> intakeList = this.intakeRepository.findAllByIntakeDateGreaterThanEqualAndIntakeDateLessThanAndUserId(
                intakeDate.atStartOfDay(), intakeDate.plusDays(1).atStartOfDay(), super.getUserUuid());
        return new Result<>(this.constructIntakeSumResponse(intakeDate, intakeList));
    }

    public Result<List<IntakeSumResponse>> getIntakeSumByMonth(final Integer year, final Integer month) {
        LocalDate start = LocalDate.of(year, month, 1);
        LocalDate end = start.plusMonths(1).withDayOfMonth(1);
        final List<IntakeSumResponse> sumList = new ArrayList<>();
        start.datesUntil(end).forEach(localDate -> sumList.add(
                this.getIntakeSumByDate(localDate).getDataOrThrow())
        );
        return new Result<>(sumList);
    }

    public Result<IntakeDTO> updateIntake(final IntakeDTO intakeDTO, final String intakeId) {
        return this.intakeRepository.findById(intakeId)
                .map(updatedIntake -> {
                    if (!updatedIntake.getUserId().equals(super.getUserUuid())) {
                        throw new ApplicationException(ApplicationError.notMatchingUserId());
                    }
                    intakeDTO.setUserId(updatedIntake.getUserId());
                    updatedIntake = super.mapFromDTO(intakeDTO);
                    updatedIntake.setId(intakeId);
                    return super.mapToDTO(this.intakeRepository.save(updatedIntake));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Intake.class.getSimpleName(), intakeId)));
    }

    public Result<Void> deleteIntake(final String intakeId) {
        if (this.intakeRepository.findById(intakeId).orElseThrow().getUserId().equals(super.getUserUuid())) {
            this.intakeRepository.deleteById(intakeId);
            return Result.ok();
        } else {
            return Result.error(ApplicationError.notMatchingUserId());
        }
    }

    private IntakeSumResponse constructIntakeSumResponse(final LocalDate intakeDate, final List<Intake> intakeList) {
        final IntakeSumResponse response = new IntakeSumResponse();
        response.setIntakeDate(intakeDate);
        response.setCarbohydrateSum((float) intakeList.stream().mapToDouble(Intake::getCarbohydrate).sum());
        response.setProteinSum((float) intakeList.stream().mapToDouble(Intake::getProtein).sum());
        response.setFatSum((float) intakeList.stream().mapToDouble(Intake::getFat).sum());
        response.setCalorieSum(intakeList.stream().mapToInt(Intake::getCalorie).sum());
        response.setWaterSum((float) intakeList.stream()
                .filter(intake -> intake.getProduct() != null && intake.getProduct().getProductType() == ProductType.WATER)
                .mapToDouble(value -> value.getQuantity() / 1000f).sum());
        return response;
    }
}
