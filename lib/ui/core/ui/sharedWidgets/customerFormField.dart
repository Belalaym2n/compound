import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

Widget customFormField({
  required String hintText,
  required IconData iconData,
  required TextEditingController controller,
  Function? changeViewOfPassword,
  bool? changeObscureText,
  required double screenWidth,
  required double screenHeight,
  bool obscureText = false,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: screenHeight / 140),
    padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 30, vertical: screenHeight * 0.005),
    height: screenHeight * 0.07,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(screenWidth * 0.03),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(iconData, color: AppColors.primary),
        suffixIcon: changeObscureText == true && obscureText == true
            ? IconButton(
                onPressed: () {
                  changeViewOfPassword!();
                },
                icon: Icon(Icons.visibility))
            : changeObscureText == true && obscureText == false
                ? IconButton(
                    onPressed: () {
                      changeViewOfPassword!();
                    },
                    icon: Icon(
                      size: screenWidth * 0.04,
                      Icons.visibility_off,
                      color: AppColors.primary,
                    ))
                : null,
        hintText: hintText,
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: screenWidth * 0.04,
        ),
      ),
    ),
  );
}
