 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';

itemWidger({
  required double screenWidth,
  required double screenHeight,
  required Function functionNavigate,
  required String image,

  required String text}){
  return

    AnimatedOpacity(
      opacity:  1.0 ,

      duration: Duration(milliseconds: 500),
  child:Padding(
    padding: const EdgeInsets.all(12.0),
    child: Material(

      color: AppColors.primary,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {
          functionNavigate();
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Material(
            color: AppColors.primary,
            child: Row(
              children: [
                // Container(
                //   width: screenWidth*0.4,
                //   height: screenHeight,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(image: AssetImage(image))
                //   ),
                // ),
                Icon(Icons.person,color: Colors.white,size: screenWidth*0.14,
                    ),
                Text(text,style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth*0.05
                ),)

              ],
            ),
          )
        ),
      ),
    ),
  ));
 }
