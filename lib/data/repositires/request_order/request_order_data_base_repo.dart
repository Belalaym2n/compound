import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code/domain/models/order_data.dart';

class HomeServiceOrderDatabaseRepo {
  Future<void> send_order_for_database({required OrderData orderData}) async {
    var collection = FirebaseFirestore.instance.collection("Orders");
    var docRef = collection.doc();
    orderData.id = docRef.id;
    await docRef.set(orderData.toJson());
  }
}
