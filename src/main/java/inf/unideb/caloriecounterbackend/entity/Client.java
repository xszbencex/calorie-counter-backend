package inf.unideb.caloriecounterbackend.entity;

import inf.unideb.caloriecounterbackend.dto.enums.Gender;

import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

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

    @Column(name = "keycloak_id", nullable = false, unique = true, updatable = false)
    private String keycloakId;

    @Column(name = "height", nullable = false)
    private Short height;

    @Column(name = "weight", nullable = false)
    private Float weight;

    @Column(name = "target_calories", nullable = false)
    private Short targetCalories;

    @Column(name = "target_carbohydate")
    private Short targetCarbohydrate;

    @Column(name = "target_protein")
    private Short targetProtein;

    @Column(name = "target_fat")
    private Short targetFat;

    @Column(name = "birth_date", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date birthDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender", nullable = false)
    private Gender gender;
}
