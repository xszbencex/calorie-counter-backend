package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.exception.ApplicationException;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import org.springframework.lang.Nullable;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Generic response entity for RestControllers.
 * @param <T> Type of the returned entity
 */
@Getter
@Setter
@ToString(callSuper = true)
public class Result<T> {

    public static final String STATUS_OK = "ok";
    public static final String STATUS_ERROR = "error";

    private Date timestamp;

    private String status;

    private String path;

    @Nullable
    private T data;

    private List<ApplicationError> errors = new ArrayList<>();

    private Result(final String status) {
        this.timestamp = new Date();
        this.status = status;
    }

    public Result() {
        this.timestamp = new Date();
        this.status = STATUS_OK;
    }

    public Result(final T data) {
        this.timestamp = new Date();
        this.status = STATUS_OK;
        this.data = data;
    }

    public static <T> Result<T> ok() {
        return new Result<>(STATUS_OK);
    }

    public static <T> Result<T> ok(final T data) {
        final Result<T> res = new Result<>(STATUS_OK);
        res.data = data;
        return res;
    }

    public static <T> Result<T> error() {
        return new Result<>(STATUS_ERROR);
    }

    public static <T> Result<T> error(final ApplicationError error) {
        final Result<T> result = new Result<>(STATUS_ERROR);
        result.errors = new ArrayList<>();
        result.errors.add(error);
        return result;
    }

    public static <T> Result<T> error(final List<ApplicationError> errors) {
        final Result<T> result = new Result<>(STATUS_ERROR);
        result.errors = errors;
        return result;
    }

    /**
     * Get the result's data, if the status is OK.
     * Otherwise it throws ApplicationException with the errors.
     * @return the data or ApplicationException is thrown.
     */
    @JsonIgnore
    public T getDataOrThrow() {
        if (Objects.equals(STATUS_OK, getStatus())) {
            return getData();
        } else {
            throw new ApplicationException(getErrors());
        }
    }
}
