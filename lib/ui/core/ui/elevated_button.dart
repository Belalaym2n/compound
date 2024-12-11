import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';

Widget elevated_button({required Function onPressed}) => Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(Constants.screenWidth, Constants.screenHeight / 15),
          backgroundColor: AppColors.primary,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () async {
          onPressed();
        },
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: Constants.screenWidth / 15,
            fontFamily: 'Nexa Bold 650',
          ),
        ),
      ),
    );
