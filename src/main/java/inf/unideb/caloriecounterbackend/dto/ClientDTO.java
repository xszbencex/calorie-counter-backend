package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.configuration.LocalDateDeserializer;
import inf.unideb.caloriecounterbackend.dto.enums.Gender;
import inf.unideb.caloriecounterbackend.dto.enums.PhysicalActivity;

import java.time.LocalDate;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Valid
@Getter
@Setter
@ToString
public class ClientDTO extends BaseDTO {

    private String keycloakId;

    @NotBlank
    private Short height;

    @NotBlank
    private Float weight;

    @NotBlank
    private Short targetCalories;

    private Short targetCarbohydrate;

    private Short targetProtein;

    private Short targetFat;

    private Float targetWater;

    @NotNull
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate birthDate;

    @NotBlank
    private Gender gender;

    @NotBlank
    private PhysicalActivity physicalActivity;

}
