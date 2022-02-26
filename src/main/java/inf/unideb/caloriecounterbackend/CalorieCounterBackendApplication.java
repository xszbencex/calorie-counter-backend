package inf.unideb.caloriecounterbackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "inf.unideb")
public class CalorieCounterBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(CalorieCounterBackendApplication.class, args);
	}

}
