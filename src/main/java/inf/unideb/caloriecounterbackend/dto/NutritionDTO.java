package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.entity.Product;

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
public class NutritionDTO extends BaseDTO {

    private String userId;

    @NotNull
    private Date nutritionDate;

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
