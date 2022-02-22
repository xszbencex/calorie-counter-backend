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

    @NotNull
    private Product product;

    @NotBlank
    private Short quantity;

    @NotNull
    private Instant nutritionDate;
}
