package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.BaseDTO;
import inf.unideb.caloriecounterbackend.entity.BaseEntity;

import java.lang.reflect.Type;
import java.util.List;
import java.util.stream.Collectors;

import org.keycloak.KeycloakPrincipal;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;

@Service
public class BaseService<D extends BaseDTO, E extends BaseEntity> {

    @Getter(AccessLevel.NONE)
    @Setter(AccessLevel.NONE)
    private final Type dtoClass;

    @Getter(AccessLevel.NONE)
    @Setter(AccessLevel.NONE)
    private final Type entityClass;

    private ModelMapper modelMapper;

    public BaseService() {
        this.dtoClass = BaseDTO.class;
        this.entityClass = BaseEntity.class;
    }

    public BaseService(final Class<D> dtoClass, final Class<E> entityClass) {
        this.dtoClass = dtoClass;
        this.entityClass = entityClass;
    }

    protected String getUserUuid() {
        if (SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")) {
            return null;
        }
        return ((KeycloakPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal())
                .getKeycloakSecurityContext().getToken().getSubject();
    }

    @Autowired
    public void setModelMapper(final ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
        this.modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
    }

    public ModelMapper getModelMapper() {
        return this.modelMapper;
    }

    public D mapToDTO(final E entity) {
        return getModelMapper().map(entity, dtoClass);
    }

    public E mapFromDTO(final D dto) {
        return getModelMapper().map(dto, entityClass);
    }

    public List<D> mapEntityListToDTOList(final List<E> entities) {
        return entities.stream().map(this::mapToDTO).collect(Collectors.toList());
    }
}
