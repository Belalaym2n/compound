 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';

itemWidger({
  required double screenWidth,
  required double screenHeight,
  required Function functionNavigate,

  required String text}){
  return InkWell(
    onTap: () {
      functionNavigate();
    },
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(24),

        child: Container(
          height: screenHeight*0.05,
          width: screenWidth,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(25),
            // border: Border.all(
            //   //color: AppColors.primary,
            //   //width: 2
            // ),

          ),
          child: Center(child: Text(text,style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth*0.05

          ),)),
        ),
      ),
    ),
  );
 }
