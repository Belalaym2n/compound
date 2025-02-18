import 'package:flutter/material.dart';

import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/constants.dart';

class ElevatedButtonStepperCarWash extends StatelessWidget {
  ElevatedButtonStepperCarWash({
    super.key,
    required this.onStepContinue,
    required this.onStepCancel,
    required this.index,
    required this.isDone,
    required this.isLoading,
  });

  Function onStepContinue;
  Function onStepCancel;
  bool isDone;
  bool isLoading;
  int index;

  @override
  Widget build(BuildContext context) {
    return isDone == true && index == 3
        ? SizedBox()
        : Row(
            children: [
              index == 3
                  ? SizedBox(width: Constants.screenWidth * 0.02)
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Constants.screenWidth * 0.03),
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
              SizedBox(width: Constants.screenWidth * 0.02),
              isLoading == false
                  ? ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Constants.screenWidth * 0.03),
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
                  : const SizedBox(),
            ],
          );
  }
}
