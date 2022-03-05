package inf.unideb.caloriecounterbackend.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@Table(name = "weight_change")
public class WeightChange extends BaseEntity {

    @Column(name = "weight", nullable = false)
    private Float weight;

    @Column(name = "set_date", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date setDate;

    @Column(name = "user_id", nullable = false, updatable = false)
    private String userId;

}
