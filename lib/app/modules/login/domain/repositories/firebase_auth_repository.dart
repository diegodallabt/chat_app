import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepository {
  Future<User?> login(String email, String password);
  Future<void> logout();
  Future<User?> getUser();
}
