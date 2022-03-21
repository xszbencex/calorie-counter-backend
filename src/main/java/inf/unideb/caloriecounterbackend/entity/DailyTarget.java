package inf.unideb.caloriecounterbackend.entity;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "daily_target")
@Access(value = AccessType.FIELD)
public class DailyTarget extends BaseEntity {

    @Column(name = "target_calories")
    private Short targetCalories;

    @Column(name = "target_carbohydate")
    private Short targetCarbohydrate;

    @Column(name = "target_protein")
    private Short targetProtein;

    @Column(name = "target_fat")
    private Short targetFat;

    @Column(name = "target_water")
    private Float targetWater;

    @Column(name = "user_id", unique = true, updatable = false)
    private String userId;
}
