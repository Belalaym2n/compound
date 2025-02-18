import 'package:flutter/material.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/firebaseAuth/creat_account.dart';
import '../../../../../data/repositires/firebaseDatabseReo/uploadOwnrRepo.dart';
import '../../../../../domain/models/owner_model.dart';
import '../../../ui/sharedWidgets/success_widget.dart';
import '../connector/register_connector.dart';

class RegisterViewModel extends BaseViewModel<RegisterConnector> {
  FirebaseRegisterRepository registerRepository;

  OwnersAuthDatabaseRepository databaseRepository;

  RegisterViewModel(this.registerRepository, this.databaseRepository);

  bool _isLoading = false;
  bool _obsureText = true;

  bool get isLoading => _isLoading;

  bool get obsureText => _obsureText;
  bool _isExpanded = false;
  int _selectIndex = -1;
  String _selectCompound = '';

  bool get isExpanded => _isExpanded;

  String get selectCompound => _selectCompound;

  int get selectIndex => _selectIndex;

  changeCompoundName(String value) {
    _selectCompound = value;
    notifyListeners();
  }

  changeCompoundIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  changeExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  changeObsureText() {
    _obsureText = !_obsureText;
    notifyListeners();
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  createUser({
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController name,
    required TextEditingController address,
    required BuildContext context,
  }) async {
    _setLoadingState(true);
    bool isEmpty = is_empty(
      compoundName: _selectCompound,
      name: name.text,
      password: password.text,
      email: email.text,
      address: address.text,
    );

    if (isEmpty) {
      _setLoadingState(false);
      return connector!.onError("All fields must be not empty");
    }
    try {
      final user = await registerRepository.registerUser(
        email: email.text,
        password: password.text,
      );
      if (user != null) {
        await registerRepository.sendEmailVerification(user);
        await databaseRepository.uploadUserToDatabase(
          OwnerModel(
              id: user.uid,
              compoundName: _selectCompound,
              address: address.text,
              name: name.text,
              email: email.text,
              isValid: false),
        );

        _setLoadingState(false);
        password.clear();
        email.clear();
        address.clear();
        name.clear();
        changeCompoundIndex(-1);
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
      _setLoadingState(false);
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
    if (email.trim().isEmpty ||
        name.trim().isEmpty ||
        compoundName.trim().isEmpty ||
        password.trim().isEmpty ||
        address.trim().isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
