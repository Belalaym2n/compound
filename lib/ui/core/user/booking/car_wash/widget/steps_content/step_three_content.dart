import 'package:flutter/material.dart';

import '../../../../../../../utils/constants.dart';
import '../../../../../ui/sharedWidgets/text_form_field_in_order.dart';
import '../../../../Orders/best_controller/widget/step_two_widget.dart';

class StepThreeContent extends StatelessWidget {
  StepThreeContent({
    super.key,
    required this.phoneController,
    required this.nameController,
  });

  TextEditingController nameController;
  TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Constants.screenHeight * 0.01,
        ),
        text_form_field_in_order(
          controller: nameController,
          label: "Enter you name",
          height: Constants.screenHeight * 0.075,
          icon: Icons.phone_callback_outlined,
        ),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.01),
        text_form_field_in_order(
          controller: phoneController,
          label: "Enter Phone Number",
          height: Constants.screenHeight * 0.075,
          icon: Icons.phone_callback_outlined,
        ),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.018),
      ],
    );
  }
}
