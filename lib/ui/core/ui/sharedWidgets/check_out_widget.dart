import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';

Widget buildPaymentOption(
    {required String text, IconData? icon, required Function checkOut}) {
  return InkWell(
    onTap: () {
      checkOut();
    },
    child: Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          border:
              Border.all(color: AppColors.primary.withOpacity(0.6), width: 2),
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon != null
                ? Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.payment,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ],
                  )
                : SvgPicture.asset(
                    "assets/images/visa.svg",
                    height: Constants.screenHeight * 0.04,
                    width: Constants.screenWidth * 0.04,
                  ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
