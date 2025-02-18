import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';

Widget customTitle(String title, double screenWidth) {
  return Text(
    title,
    style: TextStyle(
      fontSize: screenWidth / 24,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      fontFamily: 'Nexa Bold 650',
    ),
  );
}
