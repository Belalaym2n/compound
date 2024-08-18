import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../notification_screen/notification_screen.dart';

notificationItem({
  required String tittle,
  String? imageUrl,
  required String description,
  required BuildContext context
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationScreen(
                tittle: tittle,
                imageUrl: imageUrl,
                description: description),
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white38,
          ),
          width: screenWidth,
          height: screenHeight * 0.12,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imageUrl!,
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.12,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print(error);
                      // Display a placeholder image if the network image fails to load
                      return Icon(
                        Icons.error,
                        size: 50,
                        color: AppColors.primary,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.01,
                height: screenHeight * 0.02,
              ),
              Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "${tittle.length > 10 ? tittle.substring(0, 10) : tittle}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                      '${description.length > 10 ? description.substring(0, 10) : description}',
                      maxLines: 1,
                      style: TextStyle(color: Colors.black))
                ],
              ),
              SizedBox(
                width: screenWidth * 0.2,
              ),
              Expanded(
                  child: Icon(
                    Icons.notification_important,
                    color: Colors.red,
                    size: screenWidth * 0.1,
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}