package inf.unideb.caloriecounterbackend.entity;

import inf.unideb.caloriecounterbackend.dto.enums.ProductType;
import inf.unideb.caloriecounterbackend.dto.enums.UnitOfMeasure;

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
@Table(name = "product")
@Access(value = AccessType.FIELD)
public class Product extends BaseEntity {

    @Column(name = "name")
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_type", nullable = false)
    private ProductType productType;

    @Enumerated(EnumType.STRING)
    @Column(name = "unit_of_measure", nullable = false)
    private UnitOfMeasure unitOfMeasure;

    @Column(name = "carbohydrate", columnDefinition = "smallint not null default 0")
    private Byte carbohydrate;

    @Column(name = "protein", columnDefinition = "smallint not null default 0")
    private Byte protein;

    @Column(name = "fat", columnDefinition = "smallint not null default 0")
    private Byte fat;

    @Column(name = "calorie", columnDefinition = "smallint not null default 0")
    private Short calorie;

    @Column(name = "comment", columnDefinition = "text")
    private String comment;

    @Column(name = "user_id", nullable = false)
    private String userId;

}
