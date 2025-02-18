import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/constants.dart';

class HomeServiceOrLandScapeStepThreeContent extends StatelessWidget {
  HomeServiceOrLandScapeStepThreeContent({super.key, required this.price});

  String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.15),
          child: Container(
            width: Constants.screenWidth,
            height: Constants.screenHeight * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
              border: Border.all(
                  color: AppColors.primary.withOpacity(0.6), width: 2),
            ),
            child: Padding(
              padding: EdgeInsets.all(Constants.screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Details",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: Constants.screenWidth * 0.035)),
                  SizedBox(height: Constants.screenHeight * 0.015),
                  const Divider(height: 2, color: Colors.black54),
                  SizedBox(height: Constants.screenHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items Total Price",
                        style: TextStyle(
                            color: AppColors.lightBlack,
                            fontSize: Constants.screenWidth * 0.038,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        price,
                        style:
                            TextStyle(fontSize: Constants.screenWidth * 0.035),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Constants.screenHeight * 0.018,
        ),
      ],
    );
  }
}
