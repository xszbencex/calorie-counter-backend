package inf.unideb.caloriecounterbackend.entity;

import java.time.Instant;

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
@Table(name = "nutrition")
@Access(value = AccessType.FIELD)
public class Nutrition extends BaseEntity {

    @Column(name = "user_id", nullable = false)
    private String userId;

    @Column(name = "nutrition_date", columnDefinition = "timestamp(6) not null default current_timestamp(6)")
    private Instant nutritionDate;

    @Column(name = "carbohydrate", columnDefinition = "smallint not null default 0")
    private Short carbohydrate;

    @Column(name = "protein", columnDefinition = "smallint not null default 0")
    private Short protein;

    @Column(name = "fat", columnDefinition = "smallint not null default 0")
    private Short fat;

    @Column(name = "kcal", columnDefinition = "smallint not null default 0")
    private Short kcal;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "quantity")
    private Short quantity;

    @Column(name = "comment", columnDefinition = "text")
    private String comment;

}
