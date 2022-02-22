package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.ProductDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.entity.Product;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.repository.ProductRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService extends BaseService<ProductDTO, Product> {

    private final ProductRepository productRepository;

    @Autowired
    public ProductService(ProductRepository productRepository) {
        super(ProductDTO.class, Product.class);
        this.productRepository = productRepository;
    }

    public Result<ProductDTO> createProduct(final ProductDTO productDTO) {
        final Product product = super.mapFromDTO(productDTO);
        return new Result<>(super.mapToDTO(this.productRepository.save(product)));
    }

    public Result<List<ProductDTO>> getAllProduct() {
        return new Result<>(super.mapEntityListToDTOList(this.productRepository.findAll()));
    }

    public Result<ProductDTO> getProductById(final String productId) {
        return this.productRepository.findById(productId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Product.class.getSimpleName(), productId)));
    }

    public Result<ProductDTO> updateProduct(final ProductDTO productDTO, final String productId) {
        return this.productRepository.findById(productId)
                .map(updatedProduct -> {
                    updatedProduct = super.mapFromDTO(productDTO);
                    updatedProduct.setId(productId);
                    return super.mapToDTO(this.productRepository.save(updatedProduct));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Product.class.getSimpleName(), productId)));
    }

    public Result<Void> deleteProduct(final String productId) {
        this.productRepository.deleteById(productId);
        return Result.ok();
    }

}
