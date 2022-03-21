package inf.unideb.caloriecounterbackend.repository;

import inf.unideb.caloriecounterbackend.entity.PersonalData;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonalDataRepository extends JpaRepository<PersonalData, String> {

    Optional<PersonalData> findPersonalDataByUserId(String userId);
}
