package inf.unideb.caloriecounterbackend.repository;

import inf.unideb.caloriecounterbackend.entity.Product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, String> {
}
