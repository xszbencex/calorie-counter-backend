package inf.unideb.caloriecounterbackend.service;

import inf.unideb.caloriecounterbackend.dto.ClientDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.dto.WeightChangeDTO;
import inf.unideb.caloriecounterbackend.entity.Client;
import inf.unideb.caloriecounterbackend.exception.ApplicationError;
import inf.unideb.caloriecounterbackend.exception.ApplicationException;
import inf.unideb.caloriecounterbackend.repository.ClientRepository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;

@Service
@NoArgsConstructor
public class ClientService extends BaseService<ClientDTO, Client> {

    private ClientRepository clientRepository;

    @Autowired
    public ClientService(final ClientRepository clientRepository) {
        super(ClientDTO.class, Client.class);
        this.clientRepository = clientRepository;
    }

    public Result<ClientDTO> createClient(final ClientDTO clientDTO) {
        final Client client = super.mapFromDTO(clientDTO);
        client.setId(null);
        client.setKeycloakId(super.getUserUuid());

        final WeightChangeDTO weightChangeDTO = new WeightChangeDTO();
        weightChangeDTO.setWeight(client.getWeight());
        weightChangeDTO.setSetDate(LocalDate.now());
        super.getWeightChangeService().createWeightChange(weightChangeDTO);

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

    public Result<ClientDTO> getClientByUserId(final String userId) {
        return this.clientRepository.findClientByKeycloakId(userId)
                .map(super::mapToDTO)
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Client.class.getSimpleName(), userId)));
    }

    public Result<ClientDTO> updateClient(final ClientDTO clientDTO, final String clientId) {
        return this.clientRepository.findById(clientId)
                .map(updatedClient -> {
                    if (!updatedClient.getKeycloakId().equals(super.getUserUuid())) {
                        throw new ApplicationException(ApplicationError.notMatchingUserId());
                    }
                    clientDTO.setKeycloakId(updatedClient.getKeycloakId());
                    updatedClient = super.mapFromDTO(clientDTO);
                    updatedClient.setId(clientId);
                    return super.mapToDTO(this.clientRepository.save(updatedClient));
                })
                .map(Result::new)
                .orElseGet(() -> Result.error(ApplicationError.entityNotFound(Client.class.getSimpleName(), clientId)));
    }

    public Result<Void> deleteClient(final String clientId) {
        if (this.clientRepository.findById(clientId).orElseThrow().getKeycloakId().equals(super.getUserUuid())) {
            this.clientRepository.deleteById(clientId);
            return Result.ok();
        } else {
            return Result.error(ApplicationError.notMatchingUserId());
        }
    }

}
