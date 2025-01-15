import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/models/owner_model.dart';

class DatabaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadUserToDatabase(OwnerModel owner) async {
    await _firestore.collection('Owners').doc(owner.id).set(owner.toJson());
  }

  Future<DocumentSnapshot> getUserDocument(String uid) async {
    return await FirebaseFirestore.instance.collection('Owners').doc(uid).get();
  }
}
