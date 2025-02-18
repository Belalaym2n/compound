import 'package:flutter/material.dart';
import 'package:qr_code/domain/models/notification_model.dart';
import 'package:qr_code/utils/app_colors.dart';

import '../../../../../utils/constants.dart';
import 'notification_detailed.dart';

class NotificationItem extends StatefulWidget {
  NotificationItem({
    super.key,
    required this.notificationModel,
  });

  NotificationModel notificationModel;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.notificationModel.date);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Constants.screenHeight * 0.018,
          vertical: Constants.screenHeight * 0.014),
      child: Column(
        children: [_notificationCard()],
      ),
    );
  }

  Widget _notificationCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(
            Constants.screenHeight * 0.014,
          ),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications,
            size: Constants.screenWidth * 0.075,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: Constants.screenWidth * 0.03),
        // Notification Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.notificationModel.title.toString(),
                    style: TextStyle(
                      fontSize: Constants.screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    widget.notificationModel.date.toString().substring(0, 16),
                    style: TextStyle(
                      fontSize: Constants.screenWidth * 0.038,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Constants.screenHeight * 0.01),
              // Description
              Text(
                widget.notificationModel.description.toString() ?? '',
                style: TextStyle(
                  fontSize: Constants.screenWidth * 0.035,
                  color: AppColors.lightBlack,
                  // Limit to 4 lines
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 4,
              ),
              SizedBox(height: Constants.screenHeight * 0.02),
              // Actions
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      print(widget.notificationModel.imageUrl);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationDetailed(
                                notificationModel: widget.notificationModel),
                          ));
                    },
                    child: Text(
                      "View Detailed",
                      style: TextStyle(
                        fontSize: Constants.screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(width: Constants.screenWidth * 0.02),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
