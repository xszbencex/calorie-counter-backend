package inf.unideb.caloriecounterbackend.controller;

import inf.unideb.caloriecounterbackend.dto.ProductDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.enums.ProductType;
import inf.unideb.caloriecounterbackend.service.ProductService;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/product")
public class ProductController {

    private final ProductService productService;

    @Autowired
    public ProductController(final ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public Result<List<ProductDTO>> getAllProduct() {
        return this.productService.getAllProduct();
    }

    @GetMapping("/user/{userId}")
    public Result<List<ProductDTO>> getAllProductByUserId(@PathVariable final String userId) {
        return this.productService.getAllProductByUserId(userId);
    }

    @GetMapping("/type/{productType}/user/{userId}")
    public Result<List<ProductDTO>> getAllProductByProductTypeAndUserId(
            @PathVariable final ProductType productType,
            @PathVariable final String userId) {
        return this.productService.getAllProductProductTypeAndByUserId(productType, userId);
    }

    @GetMapping("/{productId}")
    public Result<ProductDTO> getProductById(
            @PathVariable final String productId) {
        return this.productService.getProductById(productId);
    }

    @PostMapping
    public Result<ProductDTO> createProduct(
            @Valid @RequestBody final ProductDTO productDTO) {
        return this.productService.createProduct(productDTO);
    }

    @PutMapping("/{productId}")
    public Result<ProductDTO> updateProduct(
            @Valid @RequestBody final ProductDTO productDTO,
            @PathVariable final String productId) {
        return this.productService.updateProduct(productDTO, productId);
    }

    @DeleteMapping("/{productId}")
    public Result<Void> deleteProduct(
            @PathVariable final String productId) {
        return this.productService.deleteProduct(productId);
    }

}
