package inf.unideb.caloriecounterbackend.repository;

import inf.unideb.caloriecounterbackend.entity.Client;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClientRepository extends JpaRepository<Client, String> {
}
