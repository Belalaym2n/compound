import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';

Widget text_form_field_in_order(
    {required String label,
    required double height,
    required IconData icon,
    required TextEditingController controller}) {
  return SizedBox(
    height: height,
    child: TextFormField(
      maxLines: 4,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.04),
          borderSide:
              BorderSide(color: AppColors.primary.withOpacity(0.6), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.04),
          borderSide: BorderSide(color: AppColors.primary, width: 2.5),
        ),
        filled: true,
        fillColor: AppColors.primary.withOpacity(0.1),
        prefixIcon: Icon(icon, color: AppColors.primary),
      ),
      cursorColor: AppColors.primary,
      style: const TextStyle(color: Colors.black87, fontSize: 16),
    ),
  );
}
