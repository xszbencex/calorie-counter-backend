package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.entity.Role;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserResponseDTO {

  private Integer id;
  private String username;
  private String email;
  List<Role> roles;

}
