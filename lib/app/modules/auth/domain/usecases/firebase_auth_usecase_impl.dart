import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/firebase_auth_repository.dart';
import 'firebase_auth_usecase.dart';

class FirebaseAuthUseCaseImpl implements FirebaseAuthUseCase {
  final FirebaseAuthRepository _firebaseAuthRepository;

  FirebaseAuthUseCaseImpl(this._firebaseAuthRepository);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final user = await _firebaseAuthRepository.login(email, password);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuthRepository.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      final user = _firebaseAuthRepository.getUser();
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
