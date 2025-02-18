import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

Widget success_widget({
  required String successMessage,
  required Function onNavigate,
  required BuildContext context,
}) {
  return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.screenWidth * 0.04),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(Constants.screenWidth * 0.06),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Constants.screenWidth * 0.04),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: Constants.screenWidth * 0.14,
                ),
                SizedBox(
                  height: Constants.screenHeight * 0.02,
                ),
                Text(
                  successMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Constants.screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Constants.screenHeight * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    onNavigate();
                  },
                  child: Text("Go to Login"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Constants.screenWidth * 0.03)),
                    foregroundColor: AppColors.primary,
                  ),
                )
              ],
            ),
          ),
        ],
      ));
}

Widget done_order_widget(BuildContext context) {
  return SafeArea(
    child: SingleChildScrollView(
        child: Stack(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.3,
            child: LottieBuilder.asset(
              "assets/json_animation/done.json",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
            )),
        Column(
          children: [
            SizedBox(
              height: Constants.screenHeight * 0.48,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(Constants.screenWidth * 0.04),
                child: Text(
                  textAlign: TextAlign.center,
                  "Your request has been successfully executed,\n we will contact you within half an hour",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: Constants.screenWidth * 0.04),
                ),
              ),
            ),
          ],
        )
      ],
    )),
  );
}
