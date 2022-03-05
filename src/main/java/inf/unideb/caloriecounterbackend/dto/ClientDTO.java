package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.dto.enums.Gender;

import java.util.Date;

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

    @NotNull
    private Date birthDate;

    @NotBlank
    private Gender gender;

}
