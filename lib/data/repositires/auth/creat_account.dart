import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return credential.user;
  }

  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
  }
}
