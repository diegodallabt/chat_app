import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDataSource {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  User? get currentUser;
}
