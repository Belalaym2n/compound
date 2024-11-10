import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/screens_for_admin/orders/show_order.dart';
import 'package:qr_code/screens/screens_for_admin/orders/view_model_order.dart';
import 'package:qr_code/utils/app_colors.dart';

import 'order_connector.dart';

class OrdersScreen extends StatefulWidget {
  final String externalId;

  OrdersScreen({required this.externalId});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<OrdersScreen>
    implements OrderConnector {
  ViewModelNotificationOrder viewModel = ViewModelNotificationOrder();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    viewModel.connector = this;
  }

  double screenHeight = 0;

  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) => Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'All Orders',
                  style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w600),
                )),
            body: Column(children: [
              calender(),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: viewModel.show_orders(selectedDate)))
            ])));
  }

  Widget calender() {
    return Container(
      //padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      margin: const EdgeInsets.all(12),
      child: CalendarTimeline(
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 360)),
        lastDate: DateTime.now().add(const Duration(days: 360)),
        onDateSelected: (date) {
          selectedDate = date;
          setState(() {});
        },
        dotColor: Colors.white,

        dayColor: Colors.black26,
        activeDayColor: Colors.white,
        activeBackgroundDayColor: AppColors.primary,
        //selectableDayPredicate: (date) => date.day != 23,
        locale: 'en_ISO',
      ),
    );
  }

  @override
  showOrders(
      {required String heading,
      required String content,
      required String id,
      required bool isDone,
      required Function onTap}) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ShowOrder(message: content, heading: heading.toString()),
              ));
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(heading,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600)),
          Padding(
              padding: EdgeInsets.all(screenWidth * 0.016),
              child: slideAction(
                  id: id,
                  orderData: order_data(
                      id: id,
                      heading: heading,
                      content: content,
                      isDone: isDone,
                      onTap: onTap)))
        ]));
  }

  Widget order_data(
      {required String heading,
      required String content,
      required String id,
      required bool isDone,
      required Function onTap}) {
    return Container(
        width: screenWidth,
        height: screenHeight * 0.12,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(screenWidth * 0.05),
          ),
          //  border: Border.all(color: Colors.black)
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  margin: EdgeInsets.all(screenWidth * 0.03),
                  child: Row(
                    children: [
                      Text(
                        content,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.033,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                      ),
                      isDone
                          ? Center(
                              child: Text(
                              "Done!",
                              style: TextStyle(
                                  color: isDone ? Colors.green : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.06),
                            ))
                          : InkWell(
                              onTap: () {
                                viewModel.done_order(
                                    id: id, serviceName: "service");
                              },
                              child: Container(
                                width: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03),
                                    color: Colors.white),
                                child: Icon(
                                  Icons.done,
                                  size: screenWidth * 0.07,
                                  color: Colors.black,
                                ),
                              ),
                            )
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget slideAction({required Widget orderData, required String id}) {
    return Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(screenWidth * 0.05)),

          padding: EdgeInsets.only(left: screenWidth * 0.05),

          onPressed: (context) {
            viewModel.delete_order(id: id, serviceName: "service");
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
          // borderRadius: BorderRadius.circular(25),
        ),
      ]),
      child: orderData,
    );
  }
}
