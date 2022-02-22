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
@Table(name = "CLIENT")
@Access(value = AccessType.FIELD)
public class Client extends BaseEntity {

    @Column(name = "keycloak_id", nullable = false, unique = true)
    private Integer keycloakId;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "height", nullable = false)
    private Integer height;

    @Column(name = "weight", nullable = false)
    private Integer weight;

    @Column(name = "birth_date", nullable = false)
    private Instant birthDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender", nullable = false)
    private Gender gender;
}
