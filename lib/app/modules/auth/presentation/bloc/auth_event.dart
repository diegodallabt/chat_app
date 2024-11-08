abstract class AuthEvent {}

class SubmitButtonPressed extends AuthEvent {
  final String email;
  final String password;

  SubmitButtonPressed({required this.email, required this.password});
}

class ToggleTab extends AuthEvent {
  final bool isLoginSelected;

  ToggleTab({required this.isLoginSelected});
}
