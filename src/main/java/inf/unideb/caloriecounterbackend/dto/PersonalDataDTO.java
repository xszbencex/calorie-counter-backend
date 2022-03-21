package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.configuration.LocalDateDeserializer;
import inf.unideb.caloriecounterbackend.dto.enums.Gender;
import inf.unideb.caloriecounterbackend.dto.enums.PhysicalActivity;

import java.time.LocalDate;

import javax.validation.Valid;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Valid
@Getter
@Setter
@ToString
public class PersonalDataDTO extends BaseDTO {

    private String userId;

    private Short height;

    private Float weight;

    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate birthDate;

    private Gender gender;

    private PhysicalActivity physicalActivity;

}
