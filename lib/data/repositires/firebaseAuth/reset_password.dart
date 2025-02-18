import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Reset password method
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e; // Propagate FirebaseAuthException for specific handling
    } catch (e) {
      throw Exception("An unexpected error occurred: $e"); // Generic error
    }
  }
}
