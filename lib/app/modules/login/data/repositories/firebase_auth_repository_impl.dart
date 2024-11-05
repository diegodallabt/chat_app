import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/firebase_auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  FirebaseAuthRepositoryImpl(this._firebaseAuthDataSource);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final user = await _firebaseAuthDataSource.signInWithEmailAndPassword(
          email, password);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuthDataSource.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      final user = _firebaseAuthDataSource.currentUser;
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
