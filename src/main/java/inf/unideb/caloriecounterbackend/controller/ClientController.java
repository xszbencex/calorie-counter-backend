package inf.unideb.caloriecounterbackend.controller;

import inf.unideb.caloriecounterbackend.dto.ClientDTO;
import inf.unideb.caloriecounterbackend.dto.Result;
import inf.unideb.caloriecounterbackend.service.ClientService;

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
@RequestMapping(path = "/client")
public class ClientController {

    private final ClientService clientService;

    @Autowired
    public ClientController(final ClientService clientService) {
        this.clientService = clientService;
    }

    @GetMapping
    public Result<List<ClientDTO>> getAllClient() {
        return this.clientService.getAllClient();
    }

    @GetMapping("/{clientId}")
    public Result<ClientDTO> getClientById(
            @PathVariable final String clientId) {
        return this.clientService.getClientById(clientId);
    }

    @PostMapping("/create")
    public Result<ClientDTO> createClient(
            @Valid @RequestBody final ClientDTO clientDTO) {
        return this.clientService.createClient(clientDTO);
    }

    @PutMapping("/{clientId}")
    public Result<ClientDTO> updateClient(
            @Valid @RequestBody final ClientDTO clientDTO,
            @PathVariable final String clientId) {
        return this.clientService.updateClient(clientDTO, clientId);
    }

    @DeleteMapping("/{clientId}")
    public Result<Void> deleteClient(
            @PathVariable final String clientId) {
        return this.clientService.deleteClient(clientId);
    }

}
