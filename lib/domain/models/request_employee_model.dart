import 'package:qr_code/domain/models/id_order_model.dart';

class RequestEmployeeModel implements IDOrderModel {
  String serviceName;
  String time;
  String phoneNumber;
  String address;
  String note;
  String id;
  bool isRead;

  RequestEmployeeModel({
    required this.address,
    required this.isRead,
    required this.note,
    required this.phoneNumber,
    required this.time,
    required this.serviceName,
    this.id = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'service': serviceName,
      'address': address,
      'note': note,
      'time': time,
      'phoneNumber': phoneNumber,
      'isRead': isRead,
      'id': id,
    };
  }

  @override
  void setId(String id) {
    this.id = id;
    // TODO: implement setId
  }
}
