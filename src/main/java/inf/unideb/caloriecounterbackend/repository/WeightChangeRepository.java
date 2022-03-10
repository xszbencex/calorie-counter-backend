package inf.unideb.caloriecounterbackend.repository;

import inf.unideb.caloriecounterbackend.entity.WeightChange;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WeightChangeRepository extends JpaRepository<WeightChange, String> {

    List<WeightChange> findAllByUserIdOrderBySetDateAsc(String userId);

}
