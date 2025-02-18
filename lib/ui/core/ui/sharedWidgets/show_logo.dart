import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_images.dart';
import '../../../../config/routes.dart';

Widget showMasLogo({
  required double screenHeight,
  required double screenWidth,
  required String name,
  bool shoImage = false,
  BuildContext? context,
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
          shoImage == true
              ? Center(
                  child: ImageIcon(
                    const AssetImage(AppImages.logoImage),
                    size: screenWidth * 50,
                    color: Colors.white,
                  ),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(),
                      Row(
                        children: [
                          // نسبة من العرض
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.04),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context!, AppRoutes.login);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                                size: screenWidth * 0.07,
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth / 14,
                                  fontFamily: 'Nexa Bold 650'),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.4,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
          if (shoImage)
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.18,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "$name",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth / 14,
                          fontFamily: 'Nexa Bold 650'),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
