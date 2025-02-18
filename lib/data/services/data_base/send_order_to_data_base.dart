import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/models/id_order_model.dart';

class SendOrderToFirebaseDatabaseService {
  Future<void> sendToDatabase(IDOrderModel model, String collectionName) async {
    try {
      var collection = FirebaseFirestore.instance.collection(collectionName);
      var docRef = collection.doc();
      model.setId(docRef.id);
      await docRef.set(model.toJson());
    } catch (e) {
      throw Exception("error to request order");
    }
  }
}
