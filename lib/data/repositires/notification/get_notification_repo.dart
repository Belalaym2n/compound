import '../../../domain/models/notification_model.dart';
import '../../services/notifcation/getNotifiationService.dart';

class NotificationRepository {
  final GetNotificationService _service;

  NotificationRepository(this._service);

  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      return await _service.fetchNotifications();
    } catch (error) {
      throw Exception('Error in NotificationRepository: ${error.toString()}');
    }
  }
}
