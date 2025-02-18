import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';

class OrderNotificationService {
  Future<http.Response> sendOrderNotification(
      {required String externalId, required String message}) async {
    try {
      final response = await http.post(
        Uri.parse('https://onesignal.com/api/v1/notifications'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Basic ${Constants.oneSignalApiKey}',
        },
        body: jsonEncode({
          'app_id': Constants.oneSignalAppId,
          //'include_email_tokens': ["belalscg@gmail.com"],
          //     'include_player_ids': [externalId],
          'include_external_user_ids': [externalId], // استخدام adminPlayerId
          //'external_id': [adminId], // استخدام adminPlayerId
          'headings': {'en': 'New Order '},
          'contents': {'en': message},
        }),
      );
      return response;
    } catch (e) {
      print("send notification nor succes");
      throw Exception("Error");
    }
  }
}
