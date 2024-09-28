class NotificationOrder {
  final String heading;
  final String order;
  final String time;

  bool isRead;

  NotificationOrder({
    required this.heading,
    required this.order,
    required this.time,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() {
    return {'heading': heading, 'order': order, 'isRead': isRead, 'time': time};
  }

  factory NotificationOrder.fromMap(Map<String, dynamic> data) {
    return NotificationOrder(
      heading: data['heading'],
      order: data['order'],
      time: (data['time']),
    );
  }
}
//
//
// @override
// Widget build(BuildContext context) {
//   var pro=Provider.of<MyProvider>(context);
//   return
