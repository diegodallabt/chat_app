abstract class LoginEvent {}

class SubmitButtonPressed extends LoginEvent {
  final String email;
  final String password;

  SubmitButtonPressed({required this.email, required this.password});
}

class ToggleTab extends LoginEvent {
  final bool isLoginSelected;

  ToggleTab({required this.isLoginSelected});
}
