import 'package:http/http.dart' as http;

import '../../services/notifcation/orderNotification.dart';

class SendNotificationRepo {
  OrderNotificationService orderNotificationService;

  SendNotificationRepo(this.orderNotificationService);

  Future<http.Response> sendOrderNotification(
      {required String externalId, required String message}) {
    return orderNotificationService.sendOrderNotification(
        externalId: externalId, message: message);
  }
}
