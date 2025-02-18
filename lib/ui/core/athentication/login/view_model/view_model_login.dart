import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/config/routes.dart';
import 'package:qr_code/ui/core/athentication/login/connector/login_connector.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/firebaseAuth/firebaseLoginRepo.dart';
import '../../../../../data/repositires/firebaseAuth/reset_password.dart';
import '../../../../../data/repositires/firebaseDatabseReo/getOwnersRepo.dart';
import '../../../../../data/services/shared_pref_helper.dart';
import '../../../ui/sharedWidgets/success_widget.dart';

class ViewModelLogin extends BaseViewModel<LoginConnector> {
  FirebaseDatabaseGetOwnersRepo firebaseDatabaseGetOwnersRepo;

  ResetPasswordRepo resetPasswordRepo;
  FirebaseLoginRepo loginRepo;

  ViewModelLogin(this.resetPasswordRepo, this.firebaseDatabaseGetOwnersRepo,
      this.loginRepo);

  bool _isLoading = false;
  bool _obsureText = true;

  bool _isDoneResetPassword = false;

  bool get isDoneResetPassword => _isDoneResetPassword;

  bool get isLoading => _isLoading;

  bool get obsureText => _obsureText;

  changeObsureText() {
    _obsureText = !_obsureText;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoadingState(true);

    if (_areCredentialsEmpty(email: email, password: password)) {
      _setLoadingState(false);
      return connector?.onError("Please enter your email and password");
    }

    try {
      final UserCredential userCredential =
          await loginRepo.loginWithEmailPassword(email, password);

      if (!userCredential.user!.emailVerified) {
        _setLoadingState(false);
        return connector?.onError(
            "Your email is not verified. Please check your inbox and verify your email to proceed");
      }

      final DocumentSnapshot userDoc = await firebaseDatabaseGetOwnersRepo
          .getUserDocument(userCredential.user!.uid);

      final String role = userDoc['role'];
      final String compoundName = userDoc['compoundName'];
      final String name = userDoc['name'];
      final bool isValid = userDoc['isValid'];

      if (!isValid) {
        _setLoadingState(false);
        return connector?.onError("Please contact the admin");
      }

      await _handleRoleNavigation(
        role: role,
        name: name,
        email: email,
        compoundName: compoundName,
      );
    } catch (error) {
      _setLoadingState(false);
      connector?.onError("Invalid email or password. Please try again.");
    }
  }

  bool _areCredentialsEmpty({
    required String email,
    required String password,
  }) {
    return email.trim().isEmpty || password.trim().isEmpty;
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> _handleRoleNavigation({
    required String role,
    required String email,
    required String name,
    required String compoundName,
  }) async {
    switch (role) {
      case 'admin':
        await SharedPreferencesHelper.saveData(key: "admin", value: true);
        connector?.navigateAdmin();
        break;

      case 'security':
        await SharedPreferencesHelper.saveData(key: "security", value: true);
        connector?.navigateSecurity();
        break;

      default:
        await SharedPreferencesHelper.saveData(key: "user", value: true);
        await SharedPreferencesHelper.saveData(
            key: "compoundName", value: compoundName);
        await SharedPreferencesHelper.saveData(key: "name", value: name);
        await SharedPreferencesHelper.saveData(
            key: "email", value: email.trim());
        connector?.navigateUser();
        break;
    }

    _setLoadingState(false);
  }

  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    _setLoadingState(true);

    if (email.trim().isEmpty) {
      _setLoadingState(false);
      connector?.onError("Please enter your email address.");
      return;
    }

    try {
      await resetPasswordRepo.resetPassword(email: email);
      _isDoneResetPassword = true;
      notifyListeners();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return success_widget(
              successMessage:
                  "please check your email message for reset password",
              onNavigate: () {
                Navigator.pushNamed(context, AppRoutes.login);
                email == '';
                notifyListeners();
                // Close the dialog
              },
              context: context,
            );
          });
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthError(e);
    } catch (e) {
      return _handleUnexpectedError(e);
    } finally {
      _setLoadingState(false);
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String errorMessage;

    switch (e.code) {
      case 'user-not-found':
        errorMessage = "No user found with this email address.";
        break;
      case 'invalid-email':
        errorMessage = "The email address provided is not valid.";
        break;
      default:
        errorMessage = "An error occurred. Please try again later.";
    }

    connector?.onError(errorMessage);
  }

  void _handleUnexpectedError(Object error) {
    connector?.onError("An unexpected error occurred. Please try again.");
    print("Unexpected error: $error");
  }
}
