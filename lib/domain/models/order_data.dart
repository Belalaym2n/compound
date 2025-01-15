import 'package:qr_code/domain/models/id_order_model.dart';

class OrderData implements IDOrderModel {
  String? area;
  String? time;
  String? phoneNumber;
  String? compoundName;
  String? address;
  String? email;
  String? id;
  String? isPaid;
  String? problem;
  String? note;
  String? service;
  bool? isRead;
  String? employeeName;
  String? date;

  OrderData({
    this.area,
    this.time,
    this.date,
    this.employeeName,
    required this.email,
    required this.compoundName,
    required this.phoneNumber,
    required this.address,
    this.id,
    required this.isPaid,
    this.problem,
    this.note,
    required this.service,
    this.isRead,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      area: json['area'] as String?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      employeeName: json['employeeName'] as String?,
      email: json['email'] as String?,
      compoundName: json['compoundName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      id: json['id'] as String?,
      isPaid: json['isPaid'] as String?,
      problem: json['problem'] as String?,
      note: json['note'] as String?,
      service: json['service'] as String?,
      isRead: json['isRead'] as bool?,
    );
  }

  /// Converts only non-null fields to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (area != null) data['area'] = area;
    if (time != null) data['time'] = time;
    if (date != null) data['date'] = date;
    if (employeeName != null) data['employeeName'] = employeeName;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (address != null) data['address'] = address;
    if (email != null) data['email'] = email;
    if (id != null) data['id'] = id;
    if (isPaid != null) data['isPaid'] = isPaid;
    if (problem != null) data['problem'] = problem;
    if (compoundName != null || compoundName == null)
      data['compoundName'] = compoundName;
    if (note != null) data['note'] = note;
    if (service != null) data['service'] = service;
    if (isRead != null) data['isRead'] = isRead;
    return data;
  }

  @override
  void setId(String id) {
    this.id = id;
  }
}
