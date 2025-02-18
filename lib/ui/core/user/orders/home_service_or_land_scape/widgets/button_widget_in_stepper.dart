import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/constants.dart';

class ButtonWidgetInStepper extends StatelessWidget {
  ButtonWidgetInStepper({
    super.key,
    required this.index,
    required this.onStepContinue,
    required this.onStepCancel,
    required this.isLoading,
  });

  int index;
  bool isLoading;
  Function onStepContinue;
  Function onStepCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        index == 3
            ? const SizedBox()
            : ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Constants.screenWidth * 0.03))),
                    backgroundColor: WidgetStatePropertyAll(AppColors.primary)),
                onPressed: () => onStepContinue(),
                child: Text(
                  index == 0
                      ? "Continue"
                      : index == 1
                          ? "Continue"
                          : "Checkout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Constants.screenWidth * 0.04),
                ),
              ),
        SizedBox(width: Constants.screenWidth * 0.02),
        index == 3 && isLoading == true
            ? const Center(child: SizedBox())
            : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.screenWidth * 0.03))),
                ),
                onPressed: onStepCancel(),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Constants.screenWidth * 0.03),
                ),
              ),
      ],
    );
  }
}
