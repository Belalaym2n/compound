import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/screens_for_admin/notification_order/notification_order_connector.dart';
import 'package:qr_code/screens/screens_for_admin/notification_order/show_order.dart';
import 'package:qr_code/screens/screens_for_admin/notification_order/view_model_notifcation_order.dart';

class NotificationOrderScreen extends StatefulWidget {
  final String externalId;

  NotificationOrderScreen({required this.externalId});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationOrderScreen>
    implements NotificationOrderConnector {
  ViewModelNotificationOrder viewModel = ViewModelNotificationOrder();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) => Scaffold(
            appBar: AppBar(title: const Text('Notifications')),
            body: Column(children: [
              Container(
                //padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(12),
                child: CalendarTimeline(
                  initialDate: selectedDate,
                  firstDate: DateTime.now().subtract(Duration(days: 360)),
                  lastDate: DateTime.now().add(Duration(days: 360)),
                  onDateSelected: (date) {
                    selectedDate = date;
                    setState(() {});
                  },
                  leftMargin: 30,
                  dotColor: Colors.white,
                  dayColor: Colors.black26,

                  activeDayColor: Colors.white,

                  activeBackgroundDayColor: Colors.black,
                  //selectableDayPredicate: (date) => date.day != 23,
                  locale: 'en_ISO',
                ),
              ),
              Expanded(child: viewModel.show_orders(selectedDate))
            ])));
  }

  @override
  showOrders(
      {required String heading,
      required String content,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    onTap();
                  },
                  icon: Icon(Icons.delete)),
              ListTile(
                title: Text(heading),
                subtitle: Text(content),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  showOrder(
      {required String heading,
      required String content,
      required Function onTap}) {
    Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          padding: const EdgeInsets.all(012),

          onPressed: (context) {
            // add delete function
          },
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
          //padding: EdgeInsets.all(12),

          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
        ),
        SlidableAction(
          // padding: const EdgeInsets.all(012),

          onPressed: (context) {},
          backgroundColor: Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
          // borderRadius: BorderRadius.circular(25),
        ),
      ]),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                  margin: EdgeInsets.all(15),
                  height: 70,
                  width: 3,
                  color:
                      //  widget.taskModel.isDone?
                      Colors.green
                  // primaryColor,
                  ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Column(
            children: [
              Text("$heading",
                  style: TextStyle(
                      color:
                          // widget.taskModel.isDone?
                          Colors.green,
                      //primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
              Text(
                "$content",
                style: TextStyle(
                    color:
                        //  widget.taskModel.isDone?
                        Colors.green
                    //Colors.black54
                    ),
              ),
            ],
          ),
          Spacer(
            flex: 4,
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  // widget.taskModel.isDone=true;
                  // setState(() {
                  // OpperationForTask.updateTask(widget.taskModel);
                  //
                  // });
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: // widget.taskModel.isDone?
                          Colors.green, //:
                      // primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 40,
                    width: 70,
                    margin: EdgeInsets.all(12),
                    child:
                        //widget.taskModel.isDone?
                        Center(
                            child: Text(
                      "Done!",
                      style: TextStyle(color: Colors.white),
                    ))
                    // Icon(Icons.done,size: 25,
                    // color: Colors.white,
                    // )
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
