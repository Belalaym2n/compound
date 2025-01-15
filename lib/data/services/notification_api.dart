// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../../domain/models/notification_order.dart';
// import '../../utils/constants.dart';
//
// class ApiNotification {
//   Future<http.Response> post_data(
//       {required String externalId, required String message}) async {
//     final response = await http.post(
//       Uri.parse('https://onesignal.com/api/v1/notifications'),
//       headers: {
//         'Content-Type': 'application/json; charset=utf-8',
//         'Authorization': 'Basic ${Constants.oneSignalApiKey}',
//       },
//       body: jsonEncode({
//         'app_id': Constants.oneSignalAppId,
//         //     'include_player_ids': [externalId],
//         'include_external_user_ids': [externalId], // استخدام adminPlayerId
//         //'external_id': [adminId], // استخدام adminPlayerId
//         'headings': {'en': 'New Order '},
//         'contents': {'en': message},
//       }),
//     );
//     return response;
//   }
//
//   Future<List<HomeServiceOrder>> fetchNotifications(String externalId) async {
//     final response = await get_orders(externalId);
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//
//       List<HomeServiceOrder> notifications = [];
//       if (data['notifications'] != null) {
//         for (var notification in data['notifications']) {
//           String? heading = notification['headings']?['en'];
//           String? message = notification['contents']?['en'];
//
//           if (heading != null && message != null) {
//             notifications.add(HomeServiceOrder(
//                 address: "",
//                 note: '',
//                 isPaid: '',
//                 phoneNumber: "",
//                 service: '',
//                 id: "",
//                 isRead: false,
//                 area: message,
//                 time: DateTime.now().toString()));
//           }
//         }
//       }
//       return notifications;
//     } else {
//       throw Exception('Failed to load notifications: ${response.body}');
//     }
//   }
//
//   Future<http.Response> get_orders(String externalId) async {
//     final url =
//         'https://onesignal.com/api/v1/notifications?app_id=${Constants.oneSignalAppId}&external_id=$externalId';
//
//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Basic ${Constants.oneSignalApiKey}',
//       },
//     );
//     return response;
//   }
//
//   Future<List<String>> fetchNotificationIds(String externalId) async {
//     final url =
//         'https://onesignal.com/api/v1/notifications?app_id=${Constants.oneSignalAppId}&external_id=$externalId';
//
//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Basic ${Constants.oneSignalApiKey}',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       List<String> notificationIds = [];
//
//       if (data['notifications'] != null) {
//         for (var notification in data['notifications']) {
//           notificationIds.add(notification['id']); // Collect notification IDs
//         }
//       }
//       return notificationIds;
//     } else {
//       throw Exception('Failed to fetch notifications: ${response.body}');
//     }
//   }
//
//   Future<void> deleteNotification(String notificationId) async {
//     final url = 'https://api.onesignal.com/notifications/$notificationId';
//
//     final response = await http.delete(Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Basic ${Constants.oneSignalApiKey}',
//         },
//         body: json.encode({
//           'app_id': Constants.oneSignalAppId,
//         }));
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete notification: ${response.body}');
//     }
//   }
//
//   Future<void> deleteNotificationsByExternalId(String externalId) async {
//     try {
//       List<String> notificationIds = await fetchNotificationIds(externalId);
//
//       for (String notificationId in notificationIds) {
//         await deleteNotification(notificationId);
//         print('Deleted notification with ID: $notificationId');
//       }
//
//       print('All notifications for external ID $externalId have been deleted.');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   Future<void> deleteNotificationFromServer(String notificationId) async {
//     final url = 'https://api.onesignal.com/notifications/$notificationId';
//
//     final response = await http.delete(Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Basic ${Constants.oneSignalApiKey}',
//           // Make sure to use your actual API key
//         },
//         body: json.encode({
//           'app_id': Constants.oneSignalAppId,
//         }));
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete notification: ${response.body}');
//     }
//   }
// }
