import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final User user;

  AuthLoginSuccess({required this.user});
}

class AuthRegisterSuccess extends AuthState {
  final User user;

  AuthRegisterSuccess({required this.user});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}

class TabChangedState extends AuthState {
  final bool isLoginSelected;

  TabChangedState({required this.isLoginSelected});
}
