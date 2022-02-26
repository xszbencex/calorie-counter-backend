package inf.unideb.caloriecounterbackend.entity;

import java.time.Instant;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

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

    @Column(name = "weight")
    private Short weight;

    @Column(name = "set_date")
    private Instant setDate;

    @Column(name = "user_id")
    private String userId;

}
