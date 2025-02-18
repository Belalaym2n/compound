import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/utils/base.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../data/repositires/notification/get_notification_repo.dart';
import '../../../../../data/services/notifcation/getNotifiationService.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../ui/sharedWidgets/shared_widgets.dart';
import '../connector/notification_connector.dart';
import '../view_model/notification_view_model.dart';
import '../widgets/notificagtion_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState
    extends BaseView<NotificationViewModel, NotificationScreen>
    implements NotificationConnector {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
    viewModel.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) => Consumer<NotificationViewModel>(
            builder: (context, viewModel, child) => Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: servic_name(
                      serviceName: "Notifications", textColor: Colors.white),
                  elevation: 4,
                  backgroundColor: AppColors.primary,
                  leading:
                      Icon(Icons.notifications_active, color: Colors.white),
                ),
                body: viewModel.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : viewModel.notifications.isEmpty
                        ? no_notification()
                        : ListView.separated(
                            itemCount: viewModel.notifications.length,
                            separatorBuilder: (context, index) => Divider(
                              thickness: 1.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            itemBuilder: (context, index) {
                              final notification =
                                  viewModel.notifications[index];
                              return NotificationItem(
                                notificationModel: notification,
                              );
                            },
                          ))));
  }

  Widget no_notification() {
    return Stack(
      children: [
        Image.asset(
          AppImages.noNotification,
          width: Constants.screenWidth,
          height: Constants.screenHeight * 0.7,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Constants.screenHeight * 0.3,
            ),
            Center(
              child: Text(
                "No Notifications Available",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: Constants.screenWidth * 0.05,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ], // Adds a subtle shadow for depth
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  NotificationViewModel init_my_view_model() {
    GetNotificationService getNotificationService = GetNotificationService();
    NotificationRepository notificationRepository =
        NotificationRepository(getNotificationService);
    // TODO: implement init_my_view_model
    return NotificationViewModel(notificationRepository);
  }

  @override
  onError(String message) {
    print("error $message");
    // TODO: implement onError
    return error_widget(context: context, message: message);
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    throw UnimplementedError();
  }
}
