import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/order_data.dart';

class DatabaseServiceGetAllOrders {
  Stream<List<OrderData>> getAllOrdersStream({
    required DateTime dateTime,
  }) {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

      return FirebaseFirestore.instance
          .collection("Orders")
          .where("date", isEqualTo: formattedDate)
          .orderBy("time", descending: true)
          .withConverter<OrderData>(
            fromFirestore: (snapshot, _) {
              return OrderData.fromJson(snapshot.data()!);
            },
            toFirestore: (order, _) {
              return order.toJson();
            },
          )
          .snapshots()
          .map((querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }
}
