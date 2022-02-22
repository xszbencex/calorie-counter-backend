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
@Table(name = "NUTRITION")
@Access(value = AccessType.FIELD)
public class Nutrition extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "quantity", columnDefinition = "smallint not null default 1")
    private Short quantity;

    @Column(name = "nutrition_date", columnDefinition = "timestamp(6) not null default current_timestamp(6)")
    private Instant nutritionDate;
}
