import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseGetOwnersService {
  Future<DocumentSnapshot> getUserDocument(String uid) async {
    try {
      return await FirebaseFirestore.instance
          .collection('Owners')
          .doc(uid)
          .get();
    } catch (e) {
      throw Exception("error");
    }
  }
}
