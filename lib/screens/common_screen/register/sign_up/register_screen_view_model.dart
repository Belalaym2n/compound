import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code/models/owner_model.dart';
import 'package:qr_code/screens/common_screen/register/sign_up/register_connector.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterConnector connector;

  createUser({
    required String email,
    required String password,
    required String name,
    required String address,
    required BuildContext context,
  }) async {
    if (email.isEmpty ||
        name.isEmpty ||
        password.isEmpty ||
        address.isEmpty ||
        password.isEmpty) {
      connector.errorMessage("All fields must be not empty", context);
    } else {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (credential.user?.uid != null) {
          credential.user!.sendEmailVerification();
          upload_user_to_database(
              documentName: credential.user!.uid.toString(),
              email: email,
              name: name,
              address: address,
              id: credential.user!.uid.toString());
          connector.navigateToLogin(context);
        }
      } on FirebaseAuthException catch (e) {
        connector.errorMessage(e.message.toString(), context);
        if (e.code == 'weak-password') {
          connector.errorMessage(e.message.toString(), context);
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          connector.errorMessage(e.message.toString(), context);
          print('The account already exists for that email.');
        }
      } catch (e) {
        print('$e');
      }
    }
  }

  upload_user_to_database({
    required String email,
    required String name,
    required String address,
    required String id,
    required String documentName,
  }) async {
    OwnerModel owner =
        OwnerModel(id: id, address: address, name: name, email: email);
    await FirebaseFirestore.instance
        .collection('Owners')
        .doc(documentName)
        .set(owner.toJson());
  }
}
