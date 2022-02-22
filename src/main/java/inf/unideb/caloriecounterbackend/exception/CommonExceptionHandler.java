package inf.unideb.caloriecounterbackend.exception;

import inf.unideb.caloriecounterbackend.dto.Result;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;

import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * Centralized exception handler for RestControllers.
 * Catches exceptions and wraps them into a {@link Result} object.
 */
@ControllerAdvice
@Order()
public class CommonExceptionHandler {

    private static final Logger LOG = Logger.getLogger(CommonExceptionHandler.class.getName());

    @ExceptionHandler(ApplicationException.class)
    public final ResponseEntity<Result<Object>> handleApplicationException(
            final ApplicationException exception,
            final HttpServletRequest request
    ) {
        LOG.log(Level.SEVERE, exception.getMessage(), exception);
        final Result<Object> error = Result.error(exception.getErrorList());
        error.setPath(request.getMethod() + " " + request.getServletPath());
        return new ResponseEntity<>(error, HttpStatus.OK);
    }

    @ExceptionHandler(AccessDeniedException.class)
    public final ResponseEntity<Result<Object>> handleAccessDeniedException(
            final AccessDeniedException exception,
            final HttpServletRequest request
    ) {
        LOG.log(Level.SEVERE, exception.getMessage(), exception);
        final Result<Object> error = Result.error(new ApplicationError(ApplicationError.ACCESS_DENIED_ERROR));
        error.setPath(request.getMethod() + " " + request.getServletPath());
        return new ResponseEntity<>(error, HttpStatus.OK);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public final ResponseEntity<Result<Void>> handleConstraintViolationException(
            final ConstraintViolationException exception, final HttpServletRequest request) {
        final List<String> validationErrors = exception.getConstraintViolations()
                .stream()
                .map(msg -> msg.getPropertyPath() + ": [" + msg.getInvalidValue() + "] - " + msg.getMessage())
                .collect(Collectors.toList());
        final Result<Void> error = Result.error(new ApplicationError(ApplicationError.VALIDATION_ERROR, validationErrors.toString()));
        error.setPath(request.getMethod() + " " + request.getServletPath());
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public final ResponseEntity<Result<Void>> handleMethodArgumentNotValidException(
            final MethodArgumentNotValidException exception, final HttpServletRequest request) {
        final List<String> validationErrors = exception.getBindingResult().getAllErrors()
                .stream()
                .map(DefaultMessageSourceResolvable::getDefaultMessage)
                .collect(Collectors.toList());
        final Result<Void> error = Result.error(new ApplicationError(ApplicationError.VALIDATION_ERROR, validationErrors.toString()));
        error.setPath(request.getMethod() + " " + request.getServletPath());
        return new ResponseEntity<>(error, HttpStatus.OK);
    }

    @ExceptionHandler(Exception.class)
    public final ResponseEntity<Result<Object>> handleException(
            final Exception exception,
            final HttpServletRequest request
    ) {
        LOG.log(Level.SEVERE, exception.getMessage(), exception);
        final Result<Object> error = Result.error(new ApplicationError(ApplicationError.EC_GENERIC_ERROR));
        error.setPath(request.getMethod() + " " + request.getServletPath());
        return new ResponseEntity<>(error, HttpStatus.OK);
    }

}
