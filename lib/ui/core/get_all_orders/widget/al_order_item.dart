import 'package:flutter/material.dart';

import '../../../../domain/models/order_data.dart';
import 'order_card.dart';

class AllOrdersItem extends StatefulWidget {
  OrderData getOrderData;

  AllOrdersItem(
      {Key? key,
// Nullable
      required this.getOrderData})
      : super(key: key);

  @override
  _AllOrdersItemState createState() => _AllOrdersItemState();
}

class _AllOrdersItemState extends State<AllOrdersItem> {
  @override
  Widget build(BuildContext context) {
    return OrderCard(
      orderData: widget.getOrderData, // Can be null
    );
  }
}
