package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.ClientDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.entity.Client;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.repository.ClientRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClientService extends BaseService<ClientDTO, Client> {

    private final ClientRepository clientRepository;

    @Autowired
    public ClientService(ClientRepository clientRepository) {
        super(ClientDTO.class, Client.class);
        this.clientRepository = clientRepository;
    }

    public Result<ClientDTO> createClient(final ClientDTO clientDTO) {
        final Client client = super.mapFromDTO(clientDTO);
        return new Result<>(super.mapToDTO(this.clientRepository.save(client)));
    }

    public Result<List<ClientDTO>> getAllClient() {
        return new Result<>(super.mapEntityListToDTOList(this.clientRepository.findAll()));
    }

    public Result<ClientDTO> getClientById(final String clientId) {
        return this.clientRepository.findById(clientId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Client.class.getSimpleName(), clientId)));
    }

    public Result<ClientDTO> updateClient(final ClientDTO clientDTO, final String clientId) {
        return this.clientRepository.findById(clientId)
                .map(updatedClient -> {
                    updatedClient = super.mapFromDTO(clientDTO);
                    updatedClient.setId(clientId);
                    return super.mapToDTO(this.clientRepository.save(updatedClient));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Client.class.getSimpleName(), clientId)));
    }

    public Result<Void> deleteClient(final String clientId) {
        this.clientRepository.deleteById(clientId);
        return Result.ok();
    }

}