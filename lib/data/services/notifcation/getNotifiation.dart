import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qr_code/utils/constants.dart';

import '../../../domain/models/notification_model.dart';

class GetNotificationService {
  static const String apiUrl = 'https://onesignal.com/api/v1/notifications';
  static String appId = Constants.oneSignalAppId;
  static String restApiKey = Constants.oneSignalApiKey;

  Future<List<NotificationModel>> fetchNotifications() async {
    final response = await http.get(
      Uri.parse('$apiUrl?app_id=$appId'),
      headers: {
        'Authorization': 'Basic $restApiKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> notifications =
          json.decode(response.body)['notifications'];
      return notifications
          .map((json) => NotificationModel.fromJson(json))
          .toList();
    } else {
      print("issue");
      throw Exception('Failed to fetch notifications');
    }
  }
}
