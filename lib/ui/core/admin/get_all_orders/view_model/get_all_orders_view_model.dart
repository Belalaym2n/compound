import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/get_order/get_order.dart';
import '../../../../../domain/models/order_data.dart';
import '../connector/get_all_orders_connector.dart';
import '../widget/al_order_item.dart';

class GetAllOrdersViewModel extends BaseViewModel<GetAllOrderConnector> {
  final GetAllOrderRepo getAllOrderRepo;

  GetAllOrdersViewModel(this.getAllOrderRepo);

  Stream<List<OrderData>> ordersStream({required DateTime date}) {
    try {
      return getAllOrderRepo.fetchOrdersStream(dateTime: date);
    } catch (e) {
      return connector!.onError(e.toString());
    }
  }

  showOrder({required DateTime date}) {
    return StreamBuilder<List<OrderData>>(
      stream: ordersStream(date: date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return connector!.showLoading();
        } else if (snapshot.hasError) {
          return connector!.onError(snapshot.hasError.toString());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No orders available.'));
        } else {
          print("get data");
          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: AllOrdersItem(
                    makeOrderDone: (id) {
                      done_order(id: id); // Pass the order ID to done_order
                    },
                    getOrderData: orders[index]),
              );
            },
          );
        }
      },
    );
  }

  done_order({required String id}) {
    try {
      print("object");
      FirebaseFirestore.instance
          .collection("Orders")
          .doc(id)
          .update({'isRead': true});
    } catch (e) {
      print(e.toString());
    }
  }
}
