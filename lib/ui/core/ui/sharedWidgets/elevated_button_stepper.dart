import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';

Widget buttonsWidget({
  required Function onStepContinue,
  required Function onStepCancel,
  required int index,
  required bool isDone,
  required bool isLoading,
}) {
  return Row(
    children: [
      isDone
          ? SizedBox()
          : ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.screenWidth * 0.03),
                  ),
                ),
              ),
              onPressed: () => onStepContinue(),
              child: Text(
                index < 2 ? "Continue" : "Checkout",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Constants.screenWidth * 0.04),
              ),
            ),
      const SizedBox(width: 8),
      isLoading == false
          ? ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.screenWidth * 0.03),
                  ),
                ),
              ),
              onPressed: () => onStepCancel(),
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Constants.screenWidth * 0.03),
              ),
            )
          : SizedBox(),
    ],
  );
}
