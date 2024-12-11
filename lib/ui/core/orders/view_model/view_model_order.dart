import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../domain/models/notification_order.dart';
import '../widgets/order_connector.dart';

class ViewModelNotificationOrder extends ChangeNotifier {
  late OrderConnector connector;
  bool isDone = false;

  show_orders(DateTime selectedDate) {
    return StreamBuilder<List<NotificationOrder>>(
      stream: get_orders(externalId: "service", dateTime: selectedDate),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("wait");
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print("error");
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Orders Found.'));
        }

        final orders = snapshot.data!;
        print("data");
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return connector.showOrders(
                id: order.id,
                isDone: order.isRead,
                onTap: () {},
                heading: order.heading,
                content: order.order);
          },
        );
      },
    );
  }

  Stream<List<NotificationOrder>> get_orders({
    required String externalId,
    required DateTime dateTime,
  }) {
    return FirebaseFirestore.instance
        .collection("Orders")
        .doc(externalId)
        .collection("Orders")
        .where("time", isEqualTo: DateUtils.dateOnly(dateTime).toString())
        .orderBy("time", descending: true) // Order by time in descending order
        .snapshots()
        .map((orders) {
      return orders.docs.map((order) {
        return NotificationOrder.fromMap(order.data());
      }).toList();
    });
  }

  done_order({required String id, required String serviceName}) {
    FirebaseFirestore.instance
        .collection("Orders")
        .doc(serviceName)
        .collection("Orders")
        .doc(id)
        .update({'isRead': true});
  }

  delete_order({required String id, required String serviceName}) {
    FirebaseFirestore.instance
        .collection("Orders")
        .doc(serviceName)
        .collection("Orders")
        .doc(id)
        .delete();
  }
}