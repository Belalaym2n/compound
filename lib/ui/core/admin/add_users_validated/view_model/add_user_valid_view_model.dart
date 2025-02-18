import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/firebaseAuth/get_owners.dart';
import '../../../../../domain/models/owner_model.dart';
import '../connector/valid_user_connedtor.dart';
import '../widgets/owner_data.dart';

class AddUserValidViewModel extends BaseViewModel<ValidUserConnector> {
  final GetOwnersRepo getOwnersRepo;

  AddUserValidViewModel(this.getOwnersRepo);

  Widget showOwners() {
    return StreamBuilder(
      stream: getOwnersRepo.getOwner(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          final errorMessage =
              snapshot.error?.toString() ?? "Unknown error occurred.";
          print("Error: $errorMessage");
          return connector!.onError(errorMessage);
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'No Users Found.',
            style: TextStyle(color: Colors.black),
          ));
        }

        final owners = snapshot.data!;

        return ListView.builder(
          itemCount: owners.length,
          itemBuilder: (context, index) {
            try {
              final ownerData = owners[index].data() as Map<String, dynamic>;
              final owner = OwnerModel.fromJson(ownerData);

              return OwnerData(
                makeValid: () {
                  updateValidation(id: owner.id);
                },
                ownerModel: owner,
              );
            } catch (e) {
              connector!.onError(e.toString());
              // Handle potential parsing errors
              print("Error parsing owner data: ${e.toString()}");
              return const SizedBox(); // Return an empty widget if parsing fails
            }
          },
        );
      },
    );
  }

  void updateValidation({required String id}) {
    try {
      FirebaseFirestore.instance
          .collection("Owners")
          .doc(id)
          .update({"isValid": true});
    } on FirebaseException catch (e) {
      connector!.onError("Firebase error: ${e.message}");
    } catch (e) {
      connector!.onError("Unexpected error: ${e.toString()}");
    }
  }
}
