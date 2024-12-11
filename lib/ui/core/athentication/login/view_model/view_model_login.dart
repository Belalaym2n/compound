import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/athentication/login/widgets/login_connector.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/services/shared_pref_helper.dart';

class ViewModelLogin extends BaseViewModel<LoginConnector> {
  login({
    required String emailController,
    required String passwordController,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.trim(),
        password: passwordController.trim(),
      );
      if (userCredential.user!.emailVerified) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Owners')
            .doc(userCredential.user?.uid)
            .get();

        String role = await userDoc['role'];
        String name = await userDoc['name'];
        bool isValid = await userDoc['isValid'];

        if (!isValid) {
          return connector!.onError("Pleas contact with admin");
        } else {
          //vvbf@gmail.com
          if (role == 'admin') {
            SharedPreferencesHelper.saveData(
                key: "admin", value: true); // Navigate to admin screen
            connector!.navigateAdmin();
          } else if (role == 'security') {
            SharedPreferencesHelper.saveData(key: "security", value: true);
            connector!.navigateSecurity();
          } else {
            SharedPreferencesHelper.saveData(key: "name", value: name);

            connector!.navigateUser();
          }
        }
      } else {
        connector!.onError("please Verified email");
      }
    } catch (e) {
      connector!.onError("Email or Password not correct");
      // Handle error (e.g., show a dialog)
    }
  }
}
