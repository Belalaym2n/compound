import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';

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

gotToChat({required double screenWidth, required Function function,required double screenHeight, required String userid}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        function();
      },
      child: Column(
        children: [
SizedBox(
  height:screenHeight*0.026,
),
          Container(
            width: screenWidth,
            height: screenHeight * 0.09,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                color: Colors.white),
            child: Center(
              child: Row(
                children: [
           IconButton(onPressed: (){},
               icon: Icon(Icons.arrow_back_ios)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle
                      ),
                      child: Image.asset(
                        AppImages.userImage,
                        height: screenHeight * 0.1,

                        width: screenWidth * 0.17,
                        fit: BoxFit.fill,

                        //dcolor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        "$userid",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w600),
                      ),

                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: (){},
                      icon: Icon(Icons.video_call,color: Colors.grey,)),
                  IconButton(onPressed: (){}
                      , icon: Icon(Icons.call,color: Colors.grey,)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
