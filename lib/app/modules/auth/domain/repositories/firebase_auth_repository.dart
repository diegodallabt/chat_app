import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRepository {
  Future<User?> login(String email, String password);
  Future<User?> register(String email, String password, String name);
  Future<void> logout();
}
