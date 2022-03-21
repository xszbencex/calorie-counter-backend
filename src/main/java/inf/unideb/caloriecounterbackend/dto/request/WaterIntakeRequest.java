package inf.unideb.caloriecounterbackend.dto.request;

import inf.unideb.caloriecounterbackend.configuration.LocalDateTimeDeserializer;

import java.time.LocalDateTime;

import javax.validation.Valid;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Valid
public class WaterIntakeRequest {

    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime intakeDate;

    private Short quantity;

    private String comment;
}
