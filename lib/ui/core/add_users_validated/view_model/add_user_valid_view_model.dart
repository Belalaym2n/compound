import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/owner_model.dart';
import '../widgets/valid_user_connedtor.dart';

class AddUserValidViewModel extends ChangeNotifier {
  late ValidUserConnector connector;

  Stream<List<DocumentSnapshot>> getUsers() {
    return FirebaseFirestore.instance
        .collection("Owners")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs);
  }

  showOwners() {
    return StreamBuilder(
      stream: getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("wait");
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print("error");
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: TextStyle(color: Colors.black),
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'No Orders Found.',
            style: TextStyle(color: Colors.black),
          ));
        }

        final orders = snapshot.data!;

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index].data() as Map<String, dynamic>;
            OwnerModel owner = OwnerModel.fromJson(order);
            print("data ${owner.email}");

            return connector.showUsers(
              id: owner.id,
              isValid: owner.isValid,
              email: owner.email,
              name: owner.name,
              address: owner.address,
            );
          },
        );
      },
    );
  }

  update_validation({required String id}) {
    print("make updata");
    try {
      FirebaseFirestore.instance
          .collection("Owners")
          .doc(id)
          .update({"isValid": true});
      print("make updata");
    } catch (e) {
      print("error $e");
    }
  }
}
