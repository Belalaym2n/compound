import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

// import 'package:qr_code/ui/core/Home_page/widgets/package.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';
import '../../Orders/request_employee/view/request_employee_screen.dart';
// import 'package.dart';

class SlideToRequestEmployee extends StatefulWidget {
  const SlideToRequestEmployee({super.key});

  @override
  State<SlideToRequestEmployee> createState() => _SlideToRequestEmployeeState();
}

class _SlideToRequestEmployeeState extends State<SlideToRequestEmployee> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<Offset>(
          begin: const Offset(-1, 0), // Start from right
          end: const Offset(0, 0), // End at original position
        ),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
        builder: (context, offset, child) {
          return Transform.translate(
            offset: Offset(Constants.screenWidth * offset.dx, 0),
            child: child,
          );
        },
        child: SlideAction(
          onSubmit: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestEmployeeScreen(),
              ),
            );
          },
          outerColor: AppColors.primary,
          sliderButtonIconSize: Constants.screenWidth * 0.04,
          sliderButtonIconPadding: Constants.screenWidth * 0.03,
          sliderRotate: true,
          innerColor: Colors.white,
          alignment: Alignment.center,
          borderRadius: Constants.screenWidth * 0.07,
          text: '  Slide to request employee',
          height: Constants.screenHeight * 0.081,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Nexa Light 350',
            fontSize: Constants.screenWidth / 20,
          ),
          elevation: 24,
        ));
  }
}
