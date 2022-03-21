package inf.unideb.caloriecounterbackend.repository;

import inf.unideb.caloriecounterbackend.entity.Intake;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IntakeRepository extends JpaRepository<Intake, String> {

    List<Intake> findAllByUserIdOrderByIntakeDateDesc(String userId);

    List<Intake> findAllByIntakeDateGreaterThanEqualAndIntakeDateLessThanAndUserId(LocalDateTime startDate, LocalDateTime endDate, String userId);

}
