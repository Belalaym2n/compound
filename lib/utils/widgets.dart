import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';

Widget customTitle(String title,double screenWidth) {
  return Text(
    title,
    style: TextStyle(
      fontSize: screenWidth / 26,
      fontWeight: FontWeight.w600,
      fontFamily: 'Nexa Bold 650',
    ),
  );
}

Widget customFormField(
    {required String hintText,
      required double screenWidth,
      required double screenHeight,
      required IconData iconData,
      required TextEditingController controller,
      required bool obscureText}) {
  return Container(
    width: screenWidth,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black26, blurRadius: 10, offset: Offset(2, 2)),
        ]),
    child: Row(
      children: [
        SizedBox(
          width: screenWidth / 6,
          child: Icon(
            iconData,
            color: AppColors.primary,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: screenWidth / 12),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenHeight / 35,
                ),
                border: InputBorder.none,
                hintText: hintText,
              ),
              maxLines: 1,
              obscureText: obscureText,
            ),
          ),
        ),
      ],
    ),
  );
}
