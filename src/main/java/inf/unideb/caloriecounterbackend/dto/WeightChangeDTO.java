package inf.unideb.caloriecounterbackend.dto;

import java.util.Date;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Valid
public class WeightChangeDTO extends BaseDTO {

    @NotBlank
    private Float weight;

    @NotBlank
    private Date setDate;

    private String userId;
}
