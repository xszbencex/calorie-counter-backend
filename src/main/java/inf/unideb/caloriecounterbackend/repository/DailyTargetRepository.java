package inf.unideb.caloriecounterbackend.repository;

import inf.unideb.caloriecounterbackend.entity.DailyTarget;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DailyTargetRepository extends JpaRepository<DailyTarget, String> {

    Optional<DailyTarget> findByUserId(String userId);
}
