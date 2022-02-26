package inf.unideb.caloriecounterbackend.dto;

import java.time.Instant;

import javax.validation.Valid;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Valid
public class WeightChangeDTO extends BaseDTO {

    private Short weight;

    private Instant setDate;

    private String userId;
}
