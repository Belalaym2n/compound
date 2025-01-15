import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../request_order/request_employee/widgets/request_employee_screen.dart';

class SlideToRequestEmployee extends StatefulWidget {
  const SlideToRequestEmployee({super.key});

  @override
  State<SlideToRequestEmployee> createState() => _SlideToRequestEmployeeState();
}

class _SlideToRequestEmployeeState extends State<SlideToRequestEmployee> {
  @override
  Widget build(BuildContext context) {
    return SlideAction(
      onSubmit: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestEmployeeScreen(),
            ));
      },
      outerColor: AppColors.primary,
      innerColor: Colors.white,
      borderRadius: Constants.screenWidth * 0.07,
      text: '     Slide to request employee',
      height: Constants.screenHeight * 0.081,
      textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nexa Light 350',
          fontSize: Constants.screenWidth / 20),
      elevation: 24,
    );
  }
}
