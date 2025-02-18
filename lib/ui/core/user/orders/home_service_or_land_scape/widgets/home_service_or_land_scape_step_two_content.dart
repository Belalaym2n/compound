import 'package:flutter/material.dart';

import '../../../../../../utils/constants.dart';
import '../../../../ui/sharedWidgets/text_form_field_in_order.dart';
import '../../best_controller/widget/step_two_widget.dart';

class HomeServiceOrLandScapeStepTwoContent extends StatelessWidget {
  HomeServiceOrLandScapeStepTwoContent(
      {super.key,
      required this.phoneController,
      required this.addressController,
      required this.noteController});

  TextEditingController addressController;
  TextEditingController phoneController;
  TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        text_form_field_in_order(
          controller: addressController,
          label: "Add Address",
          height: Constants.screenHeight * 0.14,
          icon: Icons.location_on,
        ),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.018),
        text_form_field_in_order(
          controller: phoneController,
          label: "Phone",
          height: Constants.screenHeight * 0.07,
          icon: Icons.phone_callback_outlined,
        ),
        SizedBox(height: Constants.screenHeight * 0.019),
        text_form_field_in_order(
          controller: noteController,
          label: "Add note",
          height: Constants.screenHeight * 0.1,
          icon: Icons.edit_note,
        ),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.018),
      ],
    );
  }
}
