package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.dto.enums.ProductType;
import inf.unideb.caloriecounterbackend.dto.enums.UnitOfMeasure;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Valid
@Getter
@Setter
@ToString
public class ProductDTO extends BaseDTO {

    @NotBlank
    private String name;

    @NotBlank
    private ProductType productType;

    @NotBlank
    private UnitOfMeasure unitOfMeasure;

    @NotBlank
    private Float carbohydrate;

    @NotBlank
    private Float protein;

    @NotBlank
    private Float fat;

    @NotBlank
    private Short calorie;

    private String comment;

    private String userId;

}
