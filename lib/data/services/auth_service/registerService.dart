import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRegisterService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerUser(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return credential.user;
    } catch (e) {
      throw Exception("Error registering user: $e");
    }
  }

  Future<void> sendEmailVerification(User user) async {
    try {
      await user.sendEmailVerification();
    } catch (e) {
      throw Exception("Error sending email verification: $e");
    }
  }
}
