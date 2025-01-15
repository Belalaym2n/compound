import '../../../domain/models/notification_model.dart';
import '../../services/notifcation/getNotifiation.dart';

class NotificationRepository {
  final GetNotificationService _service;

  NotificationRepository(this._service);

  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      final notifications = await _service.fetchNotifications();
      return notifications;
    } catch (e) {
      throw Exception('Error in NotificationRepository: $e');
    }
  }
}
