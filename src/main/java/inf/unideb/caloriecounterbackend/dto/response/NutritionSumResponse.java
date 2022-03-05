package inf.unideb.caloriecounterbackend.dto.response;

import javax.validation.Valid;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Valid
public class NutritionSumResponse {

    private Float carbohydrateSum;

    private Float proteinSum;

    private Float fatSum;

    private Integer calorieSum;
}
