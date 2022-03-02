package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.dto.enums.Gender;

import java.time.Instant;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Valid
@Getter
@Setter
@ToString
public class ClientDTO extends BaseDTO {

    @NotBlank
    private String keycloakId;

    @NotBlank
    private String name;

    @NotBlank
    private Short height;

    @NotBlank
    private Short weight;

    @NotBlank
    private Short targetCalories;

    private Short targetCarbohydrate;

    private Short targetProtein;

    private Short targetFat;

    @NotNull
    private Instant birthDate;

    @NotBlank
    private Gender gender;

}
