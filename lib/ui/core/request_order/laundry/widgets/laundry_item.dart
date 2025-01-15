import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_images.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';
import '../../../ui/sharedWidgets/text_form_field_in_order.dart';
import '../../../ui/shared_widgets.dart';

class LaundryItem extends StatefulWidget {
  LaundryItem({
    super.key,
    required this.noteController,
    required this.addressController,
    required this.phoneController,
    required this.requestEmployee,
    required this.isLoading,
  });

  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController noteController;
  bool isLoading;
  Function requestEmployee;

  @override
  State<LaundryItem> createState() => _LaundryItemState();
}

class _LaundryItemState extends State<LaundryItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: servic_name(serviceName: "Laundry"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.screenWidth * 0.04),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              laundry_image(),
              SizedBox(
                height: Constants.screenHeight * 0.02,
              ),
              text_form_field_in_order(
                controller: widget.addressController,
                label: "Add Address",
                height: Constants.screenHeight * 0.14,
                icon: Icons.location_on,
              ),
              SizedBox(height: Constants.screenHeight * 0.018),
              space_divider(),
              SizedBox(height: Constants.screenHeight * 0.018),
              text_form_field_in_order(
                controller: widget.phoneController,
                label: "Phone",
                height: Constants.screenHeight * 0.06,
                icon: Icons.phone_callback_outlined,
              ),
              SizedBox(height: Constants.screenHeight * 0.018),
              space_divider(),
              SizedBox(height: Constants.screenHeight * 0.019),
              text_form_field_in_order(
                controller: widget.noteController,
                label: "add any note",
                height: Constants.screenHeight * 0.1,
                icon: Icons.edit_note,
              ),
              SizedBox(height: Constants.screenHeight * 0.018),
              space_divider(),
              SizedBox(
                height: Constants.screenHeight * 0.02,
              ),
              request_employee(),
              SizedBox(height: Constants.screenHeight * 0.018),
            ],
          ),
        ),
      ),
    );
  }

  space_divider() {
    return Divider(
      height: Constants.screenHeight * 0.005,
      color: Colors.blueGrey.withOpacity(0.5),
      thickness: 1.5,
    );
  }

  Widget request_employee() {
    return SlideAction(
      onSubmit: () {
        widget.requestEmployee();
        return null;
      },
      outerColor: Colors.white,
      innerColor: AppColors.primary,
      borderRadius: Constants.screenWidth * 0.05,
      text: widget.isLoading
          ? "Loading..." // عرض النص أثناء التحميل
          : '     Slide to request employee',
      height: Constants.screenHeight * 0.081,
      sliderButtonIcon: widget.isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Icon(Icons.arrow_forward, color: Colors.white),
      textStyle: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nexa Light 350',
          fontSize: Constants.screenWidth / 20),
      elevation: 24,
    );
  }

  laundry_image() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.05),
          child: Image.asset(
            fit: BoxFit.fill,
            width: Constants.screenWidth,
            height: Constants.screenHeight * 0.26,
            AppImages.laundry,
          )),
    );
  }
}
