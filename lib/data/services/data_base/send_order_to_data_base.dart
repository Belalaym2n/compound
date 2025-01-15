import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/models/id_order_model.dart';

class SendOrderToDatabase {
  Future<void> sendToDatabase(IDOrderModel model, String collectionName) async {
    var collection = FirebaseFirestore.instance.collection(collectionName);
    var docRef = collection.doc();
    model.setId(docRef.id);
    await docRef.set(model.toJson());
  }
}
