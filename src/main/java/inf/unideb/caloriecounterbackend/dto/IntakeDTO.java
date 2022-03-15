package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.configuration.LocalDateDeserializer;
import inf.unideb.caloriecounterbackend.entity.Product;

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
public class IntakeDTO extends BaseDTO {

    private String userId;

    @NotNull
    @JsonDeserialize(using = LocalDateDeserializer.class)
    private LocalDate intakeDate;

    @NotBlank
    private Float carbohydrate;

    @NotBlank
    private Float protein;

    @NotBlank
    private Float fat;

    @NotBlank
    private Short calorie;

    private Product product;

    private Short quantity;

    private String comment;

}
