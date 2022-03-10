package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.configuration.LocalDateDeserializer;

import java.time.LocalDate;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

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
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate setDate;

    private String userId;
}
