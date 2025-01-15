import 'package:firebase_auth/firebase_auth.dart';

class LoginAccount {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> loginWithEmailPassword(
      String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }
}
