abstract class AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}

class RegisterButtonPressed extends AuthEvent {
  final String email;
  final String password;

  RegisterButtonPressed({required this.email, required this.password});
}

class ToggleTab extends AuthEvent {
  final bool isLoginSelected;

  ToggleTab({required this.isLoginSelected});
}
