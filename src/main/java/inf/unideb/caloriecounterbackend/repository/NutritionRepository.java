package inf.unideb.caloriecounterbackend.repository;

import inf.unideb.caloriecounterbackend.entity.Nutrition;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NutritionRepository extends JpaRepository<Nutrition, String> {
}
