package inf.unideb.caloriecounterbackend.exception;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Holds information about errors, exceptions raised in the backend application.
 */
@Getter
@Setter
@ToString(callSuper = true)
public class ApplicationError {

    /**
     * GAE-101: Generic Application Error.
     */
    public static final String EC_GENERIC_ERROR = "GAE-101";

    /**
     * GAE-102: Validation Error.
     */
    public static final String VALIDATION_ERROR = "GAE-102";

    public static final String ACCESS_DENIED_ERROR = "ADE-101";

    public static final String OPERATION_ERROR = "OPE-101";

    public static final String KEYCLOAK_ERROR = "KCE-101";

    protected static final Map<String, String> TITLES = new HashMap<>();
    protected static final Map<String, String> MESSAGE_TEMPLATES = new HashMap<>();

    private static final String TITLE = "Alkalmazás hiba";

    private static final String VALIDATION_ERROR_TITLE = "Validációs hiba";

    private static final String ACCESS_DENIED_TITLE = "Jogosultság hiba";

    private String code;
    private String title;
    private String message;

    public static final String ENTITY_NOT_FOUND = "201";
    public static final String ENTITY_ALREADY_EXISTS = "202";
    public static final String ERROR_DURING_SAVE = "203";

    public static final String NOT_MATCHING_USER_ID = "301";

    static {
        TITLES.put(EC_GENERIC_ERROR, TITLE);
        TITLES.put(VALIDATION_ERROR, VALIDATION_ERROR_TITLE);
        TITLES.put(ACCESS_DENIED_ERROR, ACCESS_DENIED_TITLE);
        TITLES.put(OPERATION_ERROR, TITLE);
        TITLES.put(KEYCLOAK_ERROR, TITLE);

        TITLES.put(ENTITY_NOT_FOUND, TITLE);
        TITLES.put(ENTITY_ALREADY_EXISTS, TITLE);
        TITLES.put(ERROR_DURING_SAVE, TITLE);
        TITLES.put(NOT_MATCHING_USER_ID, TITLE);

        MESSAGE_TEMPLATES.put(EC_GENERIC_ERROR, "Ismeretlen hiba.");
        MESSAGE_TEMPLATES.put(VALIDATION_ERROR, "Validációs hibák: {0}");
        MESSAGE_TEMPLATES.put(ACCESS_DENIED_ERROR, "A felhasználó nem rendelkezik a megfelelő jogosultsággal.");
        MESSAGE_TEMPLATES.put(OPERATION_ERROR, "The given filter operation is not supported or wrong!");
        MESSAGE_TEMPLATES.put(KEYCLOAK_ERROR, "Error during Keycloak Admin Client communication!");

        MESSAGE_TEMPLATES.put(ENTITY_NOT_FOUND, "Nem található {0} entitás a megadott ID-val: {1}");
        MESSAGE_TEMPLATES.put(ENTITY_ALREADY_EXISTS, "Az entitás már létezik.");
        MESSAGE_TEMPLATES.put(ERROR_DURING_SAVE, "Hiba a(z) {0} entitás mentése közben.");

        MESSAGE_TEMPLATES.put(NOT_MATCHING_USER_ID, "Csak a saját elemeit módosíthatja/törölheti.");
    }

    public ApplicationError() {
    }

    public ApplicationError(final String code) {
        this.code = code;
        this.title = TITLES.get(code);
        this.message = MESSAGE_TEMPLATES.get(code);
    }

    public ApplicationError(final String code, final String title, final String message) {
        this.code = code;
        this.title = title;
        this.message = message;
    }

    public ApplicationError(final String code, final Object param) {
        this.code = code;
        this.title = TITLES.get(code);
        this.message = format(code, new Object[]{param});
    }

    public ApplicationError(final String code, final Object[] params) {
        this.code = code;
        this.title = TITLES.get(code);
        this.message = format(code, params);
    }

    public static ApplicationError operationDoestExist() {
        return new ApplicationError(OPERATION_ERROR);
    }

    public static ApplicationError keycloakError() {
        return new ApplicationError(KEYCLOAK_ERROR);
    }

    protected static String format(final String code, final Object[] params) {
        final String template = MESSAGE_TEMPLATES.get(code);
        return MessageFormat.format(template, params);
    }

    protected static String getInfo(
            final String code,
            final String title,
            final String message) {
        return MessageFormat.format("[{0}] {1}: {2}", code, title, message);
    }

    /**
     * Formázott hibaüzenet.
     * @return hibaüzenet
     */
    public String getInfo() {
        return getInfo(code, title, message);
    }

    public static ApplicationError entityNotFound(final String entityName, final String entityId) {
        return new ApplicationError(ENTITY_NOT_FOUND, new Object[]{entityName, entityId});
    }

    public static ApplicationError entityNotFound(final String entityName, final String idType, final String idValue) {
        return new ApplicationError(ENTITY_NOT_FOUND, new Object[]{entityName, idType + "=" + idValue});
    }

    public static ApplicationError entityAlreadyExists() {
        return new ApplicationError(ENTITY_ALREADY_EXISTS);
    }

    public static ApplicationError notMatchingUserId() {
        return new ApplicationError(NOT_MATCHING_USER_ID);
    }

}
