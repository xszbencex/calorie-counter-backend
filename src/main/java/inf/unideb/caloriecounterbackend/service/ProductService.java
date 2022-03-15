package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.ProductDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.enums.ProductType;
import inf.unideb.caloriecounterbackend.entity.Product;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.exception.ApplicationException;
import inf.unideb.caloriecounterbackend.repository.ProductRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;

@Service
@NoArgsConstructor
public class ProductService extends BaseService<ProductDTO, Product> {

    private static final String WATER_NAME = "Víz";
    private static final String WATER_USER_ID = "EVERYONE";

    private ProductRepository productRepository;

    @Autowired
    public ProductService(final ProductRepository productRepository) {
        super(ProductDTO.class, Product.class);
        this.productRepository = productRepository;
    }

    public Result<ProductDTO> createProduct(final ProductDTO productDTO) {
        final Product product = super.mapFromDTO(productDTO);
        product.setId(null);
        product.setUserId(super.getUserUuid());
        return new Result<>(super.mapToDTO(this.productRepository.save(product)));
    }

    public Result<List<ProductDTO>> getAllProduct() {
        return new Result<>(super.mapEntityListToDTOList(this.productRepository.findAll()));
    }

    public Result<List<ProductDTO>> getAllProductByUserId(final String userId) {
        return new Result<>(super.mapEntityListToDTOList(this.productRepository.findAllByUserId(userId)));
    }

    public Result<List<ProductDTO>> getAllProductProductTypeAndByUserId(final ProductType productType, final String userId) {
        return new Result<>(super.mapEntityListToDTOList(this.productRepository.findAllByProductTypeAndUserId(productType, userId)));
    }

    public Result<ProductDTO> getProductById(final String productId) {
        return this.productRepository.findById(productId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Product.class.getSimpleName(), productId)));
    }

    public Result<ProductDTO> getWaterProduct() {
        return new Result<>(this.mapToDTO(this.getWaterProductEntity()));
    }

    public Result<ProductDTO> updateProduct(final ProductDTO productDTO, final String productId) {
        return this.productRepository.findById(productId)
                .map(updatedProduct -> {
                    if (!updatedProduct.getUserId().equals(super.getUserUuid())) {
                        throw new ApplicationException(ApplicationError.notMatchingUserId());
                    }
                    productDTO.setUserId(updatedProduct.getUserId());
                    updatedProduct = super.mapFromDTO(productDTO);
                    updatedProduct.setId(productId);
                    return super.mapToDTO(this.productRepository.save(updatedProduct));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Product.class.getSimpleName(), productId)));
    }

    public Result<Void> deleteProduct(final String productId) {
        if (this.productRepository.findById(productId).orElseThrow().getUserId().equals(super.getUserUuid())) {
            this.productRepository.deleteById(productId);
            return Result.ok();
        } else {
            return Result.error(ApplicationError.notMatchingUserId());
        }
    }

    public Product getWaterProductEntity() {
        return this.productRepository.getByNameAndUserIdAndProductType(WATER_NAME, WATER_USER_ID, ProductType.WATER)
                .orElseThrow(() -> new ApplicationException(ApplicationError.entityNotFound(Product.class.getSimpleName(), "Water")));
    }

}
