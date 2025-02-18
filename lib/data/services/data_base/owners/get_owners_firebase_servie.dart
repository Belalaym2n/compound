import 'package:cloud_firestore/cloud_firestore.dart';

class GetOwnerFirebaseService {
  Stream<List<DocumentSnapshot>> getOwners() {
    try {
      return FirebaseFirestore.instance
          .collection("Owners")
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs);
    } on FirebaseException catch (e) {
      throw Exception("Firebase error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}
