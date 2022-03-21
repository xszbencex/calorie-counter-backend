package inf.unideb.caloriecounterbackend.dto;

import javax.validation.Valid;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Valid
@Getter
@Setter
@ToString
public class DailyTargetDTO extends BaseDTO {

    private Short targetCalories;

    private Short targetCarbohydrate;

    private Short targetProtein;

    private Short targetFat;

    private Float targetWater;

    private String userId;
}
