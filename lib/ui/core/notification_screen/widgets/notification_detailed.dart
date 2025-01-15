import 'package:flutter/material.dart';
import 'package:qr_code/domain/models/notification_model.dart';
import 'package:qr_code/ui/core/ui/shared_widgets.dart';
import 'package:qr_code/utils/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../utils/app_colors.dart';

class NotificationDetailed extends StatefulWidget {
  final NotificationModel notificationModel;

  NotificationDetailed({super.key, required this.notificationModel});

  @override
  State<NotificationDetailed> createState() => _NotificationDetailedState();
}

class _NotificationDetailedState extends State<NotificationDetailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: servic_name(serviceName: "Notification Details"),
        elevation: 0,
        // No shadow for a cleaner look
        backgroundColor: Colors.transparent,
        // Transparent background to match design
        iconTheme: IconThemeData(
            color:
                AppColors.primary), // Set the app bar icon color to match theme
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.screenWidth * 0.04),
        // Add padding to body for spacing
        child: ListView(
          children: [
            if (widget.notificationModel.imageUrl != null) _buildImage(),

            SizedBox(height: Constants.screenHeight * 0.03),
            // Spacing between image and title

            // Headline (Title)
            _buildHeadline(),

            SizedBox(height: Constants.screenHeight * 0.02),
            // Add space after headline

            // Description
            _buildDescription(),
            SizedBox(height: Constants.screenHeight * 0.07),

            // Space at the bottom
          ],
        ),
      ),
    );
  }

  // Function to build and display the image
  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Constants.screenWidth * 0.02),
      // Rounded corners for image
      child: Image.network(
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Skeletonizer(
                child: Container(
              width: Constants.screenWidth,
              height: Constants.screenHeight * 0.3,
              color: Colors.black,
            ));
          }
        },
        widget.notificationModel.imageUrl!,
        fit: BoxFit.fill,
        width: double.infinity, // Make the image stretch across the width
        height:
            Constants.screenHeight * 0.3, // Set the image height proportionally
      ),
    );
  }

  // Function to build the headline (title)
  Widget _buildHeadline() {
    return Text(
      widget.notificationModel.title,
      style: TextStyle(
        fontSize: Constants.screenWidth * 0.055,
        // Slightly larger font size for headline
        fontWeight: FontWeight.w600,
        color: AppColors.primary, // Use primary color for consistency
      ),
      textAlign: TextAlign.start, // Center align the headline
    );
  }

  // Function to build the description
  Widget _buildDescription() {
    return Text(
      widget.notificationModel.description ?? 'No description available.',
      style: TextStyle(
        fontSize: Constants.screenWidth * 0.035,
        // Consistent font size for description
        fontWeight: FontWeight.w400,
        color: AppColors.lightBlack, // Use a softer color for the description
      ),
      // Justify text for a clean look
      // Limit description to 4 lines
      // Add "..." if the text overflows
    );
  }
}
