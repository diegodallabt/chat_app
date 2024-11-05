abstract class LoginEvent {}

class SubmitButtonPressed extends LoginEvent {
  final String email;
  final String password;

  SubmitButtonPressed({required this.email, required this.password});
}
