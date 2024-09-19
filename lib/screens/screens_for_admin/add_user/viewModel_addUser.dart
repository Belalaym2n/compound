import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/userModel.dart';

class ViewmodelAdduser extends ChangeNotifier {
  uploadData({
    required TextEditingController idController,
    required TextEditingController passwordController,
    required TextEditingController phoneNumberController,
    required TextEditingController addressController,
    required TextEditingController ownerName,
    required BuildContext context,
  }) async {
    if (idController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty) {
      try {
        UserMode userMode = UserMode(
            password: passwordController.text,
            address: addressController.text,
            phoneNumber: phoneNumberController.text,
            id: idController.text);
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Owners')
            .where('id')
            .get();

        bool hasBeenExsistBefore = querySnapshot.docs
            .any((doc) => doc['id'].toString() == idController.text);
        final docRef =
            FirebaseFirestore.instance.collection('Owners').doc(ownerName.text);

        final docSnapshot = await docRef.get();

        if (hasBeenExsistBefore || docSnapshot.exists) {
          print('hi');
          return _showError(
              message: 'Id or name Already Exist before ', context: context);
        }
        await uploadToCollection(
            nameUser: ownerName.text,
            collectionName: "Owners",
            data: userMode.toJson());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "User has been added Successfully",
              style: TextStyle(fontSize: 18.0),
            )));
        ownerName.clear();
        passwordController.clear();
        idController.clear();
        phoneNumberController.clear();
        addressController.clear();
      } catch (e) {
        return _showError(
            message: 'all data must be not empty', context: context);
      }
    }
  }

  uploadToCollection(
      {required String collectionName,
      required String nameUser,
      required Map<String, dynamic> data}) {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(nameUser)
        .set(data);
  }

  void _showError({required String message, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
