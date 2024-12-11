import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationModel {
  String? image;
  String tittle;
  String description;

  NotificationModel({
    this.image,
    required this.tittle,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'tittle': tittle,
        'image': image,
        'description': description,
      };

  NotificationModel.fromJson(Map<String, dynamic> json)
      : this(
          tittle: json['tittle'] as String,
          image: json['image'] as String,
          description: json['description'] as String,
        );
}

class NotificationService {
  static Future<void> saveNotifications(
      List<NotificationModel> newNotifications) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve existing notifications
    String? existingJsonString = prefs.getString('notifications');
    List<NotificationModel> existingNotifications = [];

    // Decode existing notifications if available
    if (existingJsonString != null) {
      try {
        List<dynamic> existingJsonList = jsonDecode(existingJsonString);
        existingNotifications = existingJsonList
            .map((jsonItem) => NotificationModel.fromJson(jsonItem))
            .toList();
      } catch (e) {
        print('Error decoding existing JSON: $e');
      }
    }

    // Combine existing notifications with new notifications
    existingNotifications.addAll(newNotifications);

    // Convert the combined list to JSON
    List<Map<String, dynamic>> jsonList = existingNotifications
        .map((notification) => notification.toJson())
        .toList();
    String updatedJsonString = jsonEncode(jsonList);

    // Save the updated JSON string to SharedPreferences
    await prefs.setString('notifications', updatedJsonString);
  }

  static Future<List<NotificationModel>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON string from SharedPreferences
    String? jsonString = prefs.getString('notifications');

    if (jsonString == null) {
      return []; // Return an empty list if no data is found
    }

    try {
      // Convert the JSON string to a list of maps
      List<dynamic> jsonList = jsonDecode(jsonString);

      // Convert the list of maps to a list of NotificationModel
      return jsonList
          .map((jsonItem) => NotificationModel.fromJson(jsonItem))
          .toList();
    } catch (e) {
      // Handle JSON decode error
      print('Error decoding JSON: $e');
      return [];
    }
  }
}
