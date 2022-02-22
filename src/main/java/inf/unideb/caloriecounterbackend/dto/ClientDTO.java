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
    private Integer keycloakId;

    @NotBlank
    private String name;

    @NotBlank
    private Integer height;

    @NotBlank
    private Integer weight;

    @NotNull
    private Instant birthDate;

    @NotBlank
    private Gender gender;

}
