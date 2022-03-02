package inf.unideb.caloriecounterbackend.entity;

import inf.unideb.caloriecounterbackend.dto.enums.Gender;

import java.time.Instant;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "client")
@Access(value = AccessType.FIELD)
public class Client extends BaseEntity {

    @Column(name = "keycloak_id", nullable = false, unique = true)
    private String keycloakId;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "height", nullable = false)
    private Short height;

    @Column(name = "weight", nullable = false)
    private Short weight;

    @Column(name = "target_calories", nullable = false)
    private Short targetCalories;

    @Column(name = "target_carbohydate")
    private Short targetCarbohydrate;

    @Column(name = "target_protein")
    private Short targetProtein;

    @Column(name = "target_fat")
    private Short targetFat;

    @Column(name = "birth_date", nullable = false)
    private Instant birthDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender", nullable = false)
    private Gender gender;
}
