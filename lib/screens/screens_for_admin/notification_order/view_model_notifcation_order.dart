import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/models/notification_order.dart';
import 'package:qr_code/screens/screens_for_admin/notification_order/notification_order_connector.dart';

class ViewModelNotificationOrder extends ChangeNotifier {
  late NotificationOrderConnector connector;

  show_orders(DateTime selectedDate) {
    return FutureBuilder<List<NotificationOrder>>(
      future: get_orders(externalId: "service", dateTime: selectedDate),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("wait");
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print("error");
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No notifications found.'));
        }

        final orders = snapshot.data!;
        print("data");
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return connector.showOrders(
                onTap: () {}, heading: order.heading, content: order.order);
          },
        );
      },
    );
  }

  Future<void> markAsRead(String id) async {}

  Future<List<NotificationOrder>> get_orders({
    required String externalId,
    required DateTime dateTime,
  }) async {
    QuerySnapshot orders = await FirebaseFirestore.instance
        .collection("Orders")
        .doc(externalId)
        .collection("Orders")
        .where("time", isEqualTo: DateUtils.dateOnly(dateTime).toString())
        .orderBy("time", descending: true) // Order by time in descending order
        .get();
    return orders.docs.map((doc) {
      return NotificationOrder.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
