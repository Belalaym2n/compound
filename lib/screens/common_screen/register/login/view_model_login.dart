import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_connector.dart';

class ViewModelLogin extends ChangeNotifier {
  late LoginConnector loginConnector;

  setUserId({required String value, required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }

  checkUser({required bool value, required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }

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

      // Fetch user role from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Owners')
          .doc(userCredential.user?.uid)
          .get();
//bel
      String role = await userDoc['role'];
      String name = await userDoc['name'];

      if (role == 'admin') {
        checkUser(value: true, key: 'isAdmin');
        // Navigate to admin screen
        loginConnector.navigateAdmin(context);
      } else if (role == 'security') {
        checkUser(value: true, key: "is security");
        // Navigate to admin screen
        loginConnector.navigateSecurity(context);
      } else {
        setUserId(value: name, key: 'name');
        loginConnector.navigateUser(context);
        //be@gmail.com 1234567
        // Navigate to user screen
      }
    } catch (e) {
      loginConnector.errorMessage("Email or Password not correct", context);
      // Handle error (e.g., show a dialog)
    }
  }
}
