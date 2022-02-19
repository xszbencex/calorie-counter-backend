package inf.unideb.caloriecounterbackend.service;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;
import lombok.Setter;

@Service
@NoArgsConstructor
public class KeycloakUserService {

    @Value("${keycloak.realm}")
    private String realm;

    @Setter
    private Keycloak keycloak;

    @Autowired
    public KeycloakUserService(final Keycloak keycloak) {
        this.keycloak = keycloak;
    }

    protected Keycloak getKeycloak() {
        return this.keycloak;
    }

    protected String getRealm() {
        return this.realm;
    }

    /**
     * User keresése id alapján.
     *
     * @param userId - userId
     * @return UserRepresentation
     */
    public UserRepresentation getUserById(
            final String userId
    ) {
        return this.keycloak.realm(realm).users().get(userId).toRepresentation();
    }
}
