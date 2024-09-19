import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

Widget showLogo({
  required double screenHeight,
  required double screenWidth,
}) =>
    Container(
      height: screenHeight / 2.5,
      width: screenWidth,
      decoration: BoxDecoration(
        color: AppColors.primary,
        //color: primaryNew,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(70),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: ImageIcon(
              const AssetImage(AppImages.logoImage),
              size: screenWidth * 50,
              color: Colors.white,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.18,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth / 14,
                      fontFamily: 'Nexa Bold 650'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
