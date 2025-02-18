import 'package:flutter/material.dart';

import '../../../../../domain/models/order_data.dart';
import 'order_card.dart';

class AllOrdersItem extends StatefulWidget {
  OrderData getOrderData;
  final Function(String) makeOrderDone;

  AllOrdersItem({
    Key? key,
// Nullable
    required this.getOrderData,
    required this.makeOrderDone,
  }) : super(key: key);

  @override
  _AllOrdersItemState createState() => _AllOrdersItemState();
}

class _AllOrdersItemState extends State<AllOrdersItem> {
  @override
  Widget build(BuildContext context) {
    return OrderCard(
      makeOrderDone: () {
        widget.makeOrderDone(widget.getOrderData.id.toString());
      },
      orderData: widget.getOrderData, // Can be null
    );
  }
}
