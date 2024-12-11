import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../domain/models/owner_model.dart';
import '../widgets/register_connector.dart';

class RegisterViewModel extends BaseViewModel<RegisterConnector> {
  createUser({
    required String email,
    required String password,
    required String name,
    required String address,
    required BuildContext context,
  }) async {
    bool isEmpty = is_empty(
        name: name, password: password, email: email, address: address);

    if (isEmpty) {
      return connector!.onError("All fields must be not empty");
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.trim(), password: password.trim());
        if (credential.user?.uid != null) {
          credential.user!.sendEmailVerification();
          upload_user_to_database(
              isValid: false,
              documentName: credential.user!.uid.toString(),
              email: email,
              name: name,
              address: address,
              id: credential.user!.uid.toString());
          connector!.navigateToLogin();
        }
      } on FirebaseAuthException catch (e) {
        connector!.onError(
          e.message.toString(),
        );
      } catch (e) {
        print('$e');
      }
    }
  }

  bool is_empty({
    required String email,
    required String password,
    required String name,
    required String address,
  }) {
    if (email.isEmpty || name.isEmpty || password.isEmpty || address.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  upload_user_to_database({
    required String email,
    required String name,
    required String address,
    required String id,
    required bool isValid,
    required String documentName,
  }) async {
    OwnerModel owner = OwnerModel(
        id: id, address: address, name: name, email: email, isValid: isValid);
    await FirebaseFirestore.instance
        .collection('Owners')
        .doc(id)
        .set(owner.toJson());
  }
}
