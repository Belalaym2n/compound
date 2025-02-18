import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';

import '../../../../utils/constants.dart';

error_widget({
  required BuildContext context,
  required String message,
}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.screenWidth * 0.05),
          ),
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: Constants.screenWidth * 0.08,
              ),
              SizedBox(width: Constants.screenWidth * 0.02),
              Text(
                "Error",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Constants.screenWidth * 0.05,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(Constants.screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius:
                      BorderRadius.circular(Constants.screenWidth * 0.03),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: Constants.screenWidth * 0.045,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Constants.screenWidth * 0.09),
                ),
                minimumSize: Size(Constants.screenWidth * 0.16,
                    Constants.screenHeight * 0.04),
                shadowColor: Colors.red.withOpacity(0.5),
                elevation: 5,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      });
}
