package inf.unideb.caloriecounterbackend.dto;

import inf.unideb.caloriecounterbackend.entity.Role;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO {

  private String username;
  private String email;
  private String password;
  List<Role> roles;

}
