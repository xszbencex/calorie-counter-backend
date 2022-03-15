package inf.unideb.caloriecounterbackend.dto.response;

import java.time.LocalDate;

import javax.validation.Valid;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Valid
public class IntakeSumResponse {

    private LocalDate intakeDate;

    private Float carbohydrateSum;

    private Float proteinSum;

    private Float fatSum;

    private Integer calorieSum;

    private Float waterSum;
}
