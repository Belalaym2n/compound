import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_code/data/services/auth_service/registerService.dart';

class FirebaseRegisterRepository {
  FirebaseRegisterService firebaseRegisterService;

  FirebaseRegisterRepository(this.firebaseRegisterService);

  Future<User?> registerUser(
      {required String email, required String password}) {
    return firebaseRegisterService.registerUser(
        email: email, password: password);
  }

  Future<void> sendEmailVerification(User user) {
    return firebaseRegisterService.sendEmailVerification(user);
  }
}
