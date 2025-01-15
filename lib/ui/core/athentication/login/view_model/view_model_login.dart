import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/athentication/login/widgets/login_connector.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/auth/data_base_repo.dart';
import '../../../../../data/repositires/auth/login_account.dart';
import '../../../../../data/services/shared_pref_helper.dart';

class ViewModelLogin extends BaseViewModel<LoginConnector> {
  final DatabaseRepository repository = DatabaseRepository();
  final LoginAccount loginAccount = LoginAccount();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  login({
    required String emailController,
    required String passwordController,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    bool isEmpty = check_is_empty(
        emailController: emailController,
        passwordController: passwordController);
    if (isEmpty) {
      _isLoading = false;
      notifyListeners();
      return connector!.onError("All fields must be not empty");
    }
    try {
      UserCredential userCredential = await loginAccount.loginWithEmailPassword(
          emailController, passwordController);

      if (userCredential.user!.emailVerified) {
        DocumentSnapshot userDoc =
            await repository.getUserDocument(userCredential.user!.uid);

        String role = await userDoc['role'];
        String compoundName = await userDoc['compoundName'];
        bool isValid = await userDoc['isValid'];

        if (!isValid) {
          _isLoading = false;
          notifyListeners();
          return connector!.onError("Pleas contact with admin");
        } else {
          //vvbf@gmail.com
          if (role == 'admin') {
            _isLoading = false;
            notifyListeners();
            SharedPreferencesHelper.saveData(
                key: "admin", value: true); // Navigate to admin screen
            connector!.navigateAdmin();
          } else if (role == 'security') {
            _isLoading = false;
            notifyListeners();
            SharedPreferencesHelper.saveData(key: "security", value: true);
            connector!.navigateSecurity();
          } else {
            _isLoading = false;
            notifyListeners();
            SharedPreferencesHelper.saveData(key: "user", value: true);
            SharedPreferencesHelper.saveData(
                key: "compoundName", value: compoundName);
            print(compoundName);
            print(
                "belal ${await SharedPreferencesHelper.getData("compoundName")}");
            connector!.navigateUser();
          }
        }
      } else {
        _isLoading = false;
        notifyListeners();
        connector!.onError("please Verify your email");
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      connector!.onError("Email or Password not correct");
      // Handle error (e.g., show a dialog)
    }
  }

  bool check_is_empty({
    required String emailController,
    required String passwordController,
  }) {
    if (emailController.trim().isEmpty || passwordController.trim().isEmpty) {
      return true;
    }
    return false;
  }
}
