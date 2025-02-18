import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';

Widget buildInputField(
    {required String label,
    required String hint,
    required TextEditingController controller,
    required Animation<Offset> position}) {
  return SlideTransition(
    position: position,
    child: TextFormField(
      controller: controller,
      maxLines: 4,
      textAlign: TextAlign.end,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: Constants.screenWidth * 0.04,
      ),
      decoration: InputDecoration(
        labelText: label,
        // Adds the label text
        labelStyle: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold, // Make the label stand out (optional)
        ),
        hintText: hint,
        // Adds the hint text
        hintStyle: TextStyle(
          color: AppColors.titleTextColor,
          fontSize: Constants.screenWidth * 0.035, // Adjust hint size
        ),
        filled: true,
        fillColor: AppColors.primary.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Constants.screenWidth * 0.02,
          ),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.8),
            width: 1.5,
          ),
        ),
      ),
    ),
  );
}
