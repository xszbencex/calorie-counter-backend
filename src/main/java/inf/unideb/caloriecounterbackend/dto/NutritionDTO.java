package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.entity.Product;

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
public class NutritionDTO extends BaseDTO {

    @NotBlank
    private String userId;

    @NotNull
    private Instant nutritionDate;

    @NotBlank
    private Short carbohydrate;

    @NotBlank
    private Short protein;

    @NotBlank
    private Short fat;

    @NotBlank
    private Short kcal;

    private Product product;

    private Short quantity;

    private String comment;

}
