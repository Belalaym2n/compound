import 'package:flutter/material.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../utils/app_colors.dart';

Widget buildSubmitButton({
  required Animation<Offset> position,
  required Function submitProblem,
  required bool isLoading,
}) {
  return SlideTransition(
    position: position, //_slideAnimation,
    child: Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize:
              Size(Constants.screenWidth * 0.92, Constants.screenHeight * 0.07),
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Constants.screenWidth * 0.024)),
        ),
        onPressed: () {
          submitProblem();
        },
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                "Send Your Problem",
                style: TextStyle(
                    fontSize: Constants.screenWidth * 0.05,
                    color: Colors.white),
              ),
      ),
    ),
  );
}
