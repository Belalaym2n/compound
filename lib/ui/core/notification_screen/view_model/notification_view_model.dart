import 'package:qr_code/ui/core/notification_screen/connector/notification_connector.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../data/repositires/notification/get_notification_repo.dart';
import '../../../../domain/models/notification_model.dart';

class NotificationViewModel extends BaseViewModel<NotificationConnector> {
  final NotificationRepository _repository;

  NotificationViewModel(this._repository);

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  List<NotificationModel> get notifications => _notifications;

  bool get isLoading => _isLoading;

  Future<void> fetchNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notifications = await _repository.fetchNotifications();
    } catch (e) {
      connector!.onError(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
