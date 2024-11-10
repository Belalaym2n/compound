import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';

import 'app_images.dart';

Widget customTitle(String title, double screenWidth) {
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
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w700, // Set the font size here
                color: Colors.black, // Optional: set text color
              ),
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: screenWidth * 0.03)),
              //minLines: 1, // لتحديد الحد الأدنى للارتفاع
              //  maxLines: null,
              obscureText: obscureText,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget storeItem({
  required double screenWidth,
  required double screenHeight,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(screenWidth * 0.03),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            border: Border.all(color: Colors.black54, width: 1)),
        height: screenHeight * 0.12,
        width: screenWidth,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.07),
                  child: Image.asset(
                    fit: BoxFit.cover,
                    AppImages.splashImage,
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.3,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  "Super Market",
                  style: TextStyle(
                      color: AppColors.lightBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.04,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  "lamirada market",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      "+201022491465",
                      style: TextStyle(
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.04,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Text(
                      "7am:7pm",
                      style: TextStyle(
                          color: AppColors.lightBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.04,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
