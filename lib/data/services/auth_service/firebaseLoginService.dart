import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> loginWithEmailPassword(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } catch (e) {
      throw Exception("Error registering user: $e");
    }
  }
}
