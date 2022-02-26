package inf.unideb.caloriecounterbackend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import inf.unideb.caloriecounterbackend.service.KeycloakUserService;

import org.keycloak.representations.idm.UserRepresentation;

@RestController
@RequestMapping(path = "/users")
public class KeycloakUserController {

    private final KeycloakUserService keycloakUserService;

    @Autowired
    public KeycloakUserController(final KeycloakUserService keycloakUserService) {
        this.keycloakUserService = keycloakUserService;
    }

    @GetMapping("/{userId}")
    public UserRepresentation getUserById(@PathVariable final String userId) {
        return this.keycloakUserService.getUserById(userId);
    }
}
