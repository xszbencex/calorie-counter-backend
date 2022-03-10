package inf.unideb.caloriecounterbackend.configuration;

import inf.unideb.caloriecounterbackend.dto.enums.ProductType;
import inf.unideb.caloriecounterbackend.dto.enums.UnitOfMeasure;
import inf.unideb.caloriecounterbackend.entity.Product;
import inf.unideb.caloriecounterbackend.repository.ProductRepository;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Component;

@Component
public class DatabaseInitializer {

    private final ProductRepository productRepository;

    public DatabaseInitializer(final ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @PostConstruct
    public void initAccount() {
        if (!this.productRepository.existsByProductType(ProductType.WATER)) {
            final Product water = new Product();
            water.setProductType(ProductType.WATER);
            water.setUserId("EVERYONE");
            water.setName("Víz");
            water.setCalorie((short) 0);
            water.setCarbohydrate(0f);
            water.setProtein(0f);
            water.setFat(0f);
            water.setUnitOfMeasure(UnitOfMeasure.MILLILITERS_100);

            this.productRepository.save(water);
        }
    }
}
