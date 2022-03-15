package inf.unideb.caloriecounterbackend.entity;

import java.time.LocalDate;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "intake")
@Access(value = AccessType.FIELD)
public class Intake extends BaseEntity {

    @Column(name = "user_id", nullable = false, updatable = false)
    private String userId;

    @Column(name = "intake_date")
    private LocalDate intakeDate;

    @Column(name = "carbohydrate", columnDefinition = "smallint not null default 0")
    private Float carbohydrate;

    @Column(name = "protein", columnDefinition = "smallint not null default 0")
    private Float protein;

    @Column(name = "fat", columnDefinition = "smallint not null default 0")
    private Float fat;

    @Column(name = "calorie", columnDefinition = "smallint not null default 0")
    private Short calorie;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "quantity")
    private Short quantity;

    @Column(name = "comment", columnDefinition = "text")
    private String comment;

}
