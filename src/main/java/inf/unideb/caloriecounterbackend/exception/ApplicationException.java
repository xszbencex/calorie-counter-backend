package inf.unideb.caloriecounterbackend.exception;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * BackEnd Application specific runtime exceptions.
 */
@Getter
@Setter
@ToString(callSuper = true)
public class ApplicationException extends RuntimeException {

    private final List<ApplicationError> errorList;

    public ApplicationException(final ApplicationError applicationError) {
        super(applicationError.getInfo());
        this.errorList = List.of(applicationError);
    }

    public ApplicationException(
            final ApplicationError applicationError,
            final Throwable cause
    ) {
        super(applicationError.getInfo(), cause);
        this.errorList = List.of(applicationError);
    }

    public ApplicationException(final List<? extends ApplicationError> appErrors) {
        this.errorList = new ArrayList<>();
        this.errorList.addAll(appErrors);
    }

    public ApplicationException(
            final List<? extends ApplicationError> appErrors,
            final Throwable cause
    ) {
        super(cause);
        this.errorList = new ArrayList<>();
        this.errorList.addAll(appErrors);
    }

    /**
     * GAE-101: Ismeretlen hiba.
     * @return GAE-101 ApplicationException
     */
    public static ApplicationException gae101() {
        return new ApplicationException(new ApplicationError(ApplicationError.EC_GENERIC_ERROR));
    }

    public static ApplicationException gae102() {
        return new ApplicationException(new ApplicationError(ApplicationError.VALIDATION_ERROR));
    }

    /**
     * Constructs a new ApplicationException with the ApplicationError's and the provided Throwable.
     * Note: Its not possible to set the Throwable for the RuntimeException after initialization,
     * that's why we create a new instance.
     * @param cause - cause
     * @return - ApplicationException
     */
    public ApplicationException addCause(final Throwable cause) {
        if (errorList == null || errorList.size() != 1) {
            return new ApplicationException(this.getErrorList(), cause);
        }
        return new ApplicationException(this.getErrorList().get(0), cause);
    }
}
