import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/notification/get_notification_repo.dart';
import '../../../../../domain/models/notification_model.dart';
import '../connector/notification_connector.dart';

class NotificationViewModel extends BaseViewModel<NotificationConnector> {
  NotificationRepository _repository;

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
    } catch (error) {
      final errorMessage = _handleError(error);
      connector?.onError(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkInternetAndFetch() async {
    final List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    final bool connected =
        connectivityResults.any((result) => result != ConnectivityResult.none);

    if (connected) {
      await fetchNotifications(); // ✅ Call API only if connected
    } else {
      print("❌ No Internet Connection");
    }
  }

  String _handleError(Object error) {
    if (error is Exception) {
      return error.toString();
    } else {
      return 'An unexpected error occurred. Please try again later.';
    }
  }
}
