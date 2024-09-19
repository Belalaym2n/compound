import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

class ApiNotification {
  Future<http.Response> post_data(
      {required String adminId, required String message}) async {
    final response = await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Basic ${Constants.oneSignalApiKey}',
      },
      body: jsonEncode({
        'app_id': Constants.oneSignalAppId,
        'include_player_ids': [adminId], // استخدام adminPlayerId
        'headings': {'en': 'رسالة جديدة'},
        'contents': {'en': message},
      }),
    );
    return response;
  }
}
