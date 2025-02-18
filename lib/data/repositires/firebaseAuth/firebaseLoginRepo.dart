import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_code/data/services/auth_service/firebaseLoginService.dart';

class FirebaseLoginRepo {
  FirebaseLoginService firebaseLoginService;

  FirebaseLoginRepo(this.firebaseLoginService);

  Future<UserCredential> loginWithEmailPassword(String email, String password) {
    return firebaseLoginService.loginWithEmailPassword(email, password);
  }
}
