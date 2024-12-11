import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';

button({
  required Function onTap,
  required String buttonName,
}) {
  return ElevatedButton(
    onPressed: () {
      onTap();
      // Functionality for submitting the order
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.019),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
      ),
    ),
    child: Text(
      buttonName,
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
  );
  //إرسال الطلب
}
