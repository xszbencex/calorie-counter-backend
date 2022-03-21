package inf.unideb.caloriecounterbackend.entity;

import inf.unideb.caloriecounterbackend.dto.enums.Gender;
import inf.unideb.caloriecounterbackend.dto.enums.PhysicalActivity;

import java.time.LocalDate;

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
@Table(name = "personal_data")
@Access(value = AccessType.FIELD)
public class PersonalData extends BaseEntity {

    @Column(name = "user_id", unique = true, updatable = false)
    private String userId;

    @Column(name = "height")
    private Short height;

    @Column(name = "weight")
    private Float weight;

    @Column(name = "birth_date")
    private LocalDate birthDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender")
    private Gender gender;

    @Enumerated(EnumType.STRING)
    @Column(name = "physical_activity")
    private PhysicalActivity physicalActivity;
}
