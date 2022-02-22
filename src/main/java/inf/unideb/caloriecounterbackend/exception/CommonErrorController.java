package inf.unideb.caloriecounterbackend.exception;

import inf.unideb.caloriecounterbackend.dto.Result;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.autoconfigure.web.servlet.error.BasicErrorController;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.boot.web.servlet.error.DefaultErrorAttributes;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Global error {@link RestController}, rendering {@link Result} entity containing information about the error.
 */
@RestController
@RequestMapping("${server.error.path:${error.path:/error}}")
public class CommonErrorController extends BasicErrorController {

    public CommonErrorController() {
        super(new DefaultErrorAttributes(), new ErrorProperties());
    }

    public CommonErrorController(final ErrorAttributes errorAttributes, final ErrorProperties errorProperties) {
        super(errorAttributes, errorProperties);
    }

    public CommonErrorController(
            final ErrorAttributes errorAttributes,
            final ErrorProperties errorProperties,
            final List<ErrorViewResolver> errorViewResolvers) {
        super(errorAttributes, errorProperties, errorViewResolvers);
    }

    /**
     * Error response for any kind of requested method.
     * @param request the original request that caused the error
     * @return ResponseEntity containing {@link Result} entity.
     */
    @RequestMapping
    @Override
    public ResponseEntity error(final HttpServletRequest request) {
        final Map<String, Object> body = getErrorAttributes(request, getErrorAttributeOptions(request, MediaType.ALL));
        final HttpStatus status = getStatus(request);
        final Result<Object> result = Result.error(new ApplicationError("HTTP-" + status.value(), (String) body.get("error"), (String) body.get("message")));
        result.setPath(request.getMethod() + " " + body.get("path"));
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

}
