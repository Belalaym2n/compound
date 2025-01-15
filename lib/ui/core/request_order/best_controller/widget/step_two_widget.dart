import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart';
import '../../../ui/sharedWidgets/text_form_field_in_order.dart';

Widget step_two_widget({
  required TextEditingController addressController,
  required TextEditingController phoneController,
  required TextEditingController noteController,
  required TextEditingController areaController,
}) {
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
      SizedBox(height: Constants.screenHeight * 0.018),
      text_form_field_in_order(
        controller: areaController,
        label: "enter you area",
        height: Constants.screenHeight * 0.07,
        icon: Icons.phone_callback_outlined,
      ),
      SizedBox(height: Constants.screenHeight * 0.019),
      text_form_field_in_order(
        controller: noteController,
        label: "add any note",
        height: Constants.screenHeight * 0.1,
        icon: Icons.edit_note,
      ),
      SizedBox(height: Constants.screenHeight * 0.018),
      space_divider(),
      SizedBox(height: Constants.screenHeight * 0.018),
    ],
  );
}

space_divider() {
  return Divider(
    height: Constants.screenHeight * 0.005,
    color: Colors.blueGrey.withOpacity(0.5),
    thickness: 1.5,
  );
}
