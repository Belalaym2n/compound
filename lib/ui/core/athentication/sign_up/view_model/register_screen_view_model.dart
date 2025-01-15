import 'package:flutter/material.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/auth/creat_account.dart';
import '../../../../../data/repositires/auth/data_base_repo.dart';
import '../../../../../domain/models/owner_model.dart';
import '../../../ui/sharedWidgets/success_widget.dart';
import '../widgets/register_connector.dart';

class RegisterViewModel extends BaseViewModel<RegisterConnector> {
  final AuthRepository _authRepository = AuthRepository();
  final DatabaseRepository _databaseRepository = DatabaseRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _isExpanded = false;
  int _selectIndex = -1;
  String _selectCompound = '';

  bool get isExpanded => _isExpanded;

  String get selectCompound => _selectCompound;

  int get selectIndex => _selectIndex;

  changeRule(String value) {
    _selectCompound = value;
    notifyListeners();
  }

  changeIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  changeExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  createUser({
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController name,
    required TextEditingController address,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    bool isEmpty = is_empty(
      compoundName: _selectCompound,
      name: name.text,
      password: password.text,
      email: email.text,
      address: address.text,
    );

    if (isEmpty) {
      _isLoading = false;
      notifyListeners();
      return connector!.onError("All fields must be not empty");
    }
    try {
      final user = await _authRepository.registerUser(
        email: email.text,
        password: password.text,
      );
      if (user != null) {
        await _databaseRepository.uploadUserToDatabase(
          OwnerModel(
              id: user.uid,
              compoundName: _selectCompound,
              address: address.text,
              name: name.text,
              email: email.text,
              isValid: false),
        );
        await _authRepository.sendEmailVerification(user);

        _isLoading = false;
        notifyListeners();
        password.clear();
        email.clear();
        address.clear();
        name.clear();
        changeIndex(-1);
        notifyListeners();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return success_widget(
                successMessage: "Account created successfully!",
                onNavigate: () {
                  Navigator.of(context).pop(); // Close the dialog
                  connector!.navigateToLogin(); // Navigate to login screen
                },
                context: context,
              );
            });
      }
    } on Exception catch (e) {
      _isLoading = false;
      notifyListeners();
      connector!.onError(e.toString());
    }
  }

  bool is_empty({
    required String email,
    required String password,
    required String name,
    required String address,
    required String compoundName,
  }) {
    if (email.isEmpty ||
        name.isEmpty ||
        compoundName.isEmpty ||
        password.isEmpty ||
        address.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
