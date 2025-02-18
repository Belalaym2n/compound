import 'package:flutter/material.dart';
import 'package:qr_code/config/routes.dart';
import 'package:qr_code/utils/app_colors.dart';

class GetStartBtn extends StatefulWidget {
  const GetStartBtn({
    super.key,
    required this.size,
    required this.textTheme,
  });

  final Size size;
  final TextTheme textTheme;

  @override
  State<GetStartBtn> createState() => _GetStartBtnState();
}

class _GetStartBtnState extends State<GetStartBtn> {
  bool isLoading = false;
  double screenWidth = 0;

  loadingHandler() {
    setState(() {
      isLoading = true;
      Future.delayed(const Duration(milliseconds: 700)).then((value) {
        isLoading = false;
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    });
  }

//be@gmail.com 1234567
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: loadingHandler,
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: widget.size.width / 1.5,
        height: widget.size.height / 13,
        decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  "Get Started Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.07,
                    fontFamily: 'Nexa Bold 650',
                  ),
                ),
        ),
      ),
    );
  }
}

class SkipBtn extends StatelessWidget {
  SkipBtn({
    super.key,
    required this.size,
    required this.textTheme,
    required this.onTap,
  });

  final Size size;
  final TextTheme textTheme;
  final VoidCallback onTap;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 60),
      width: size.width / 1.5,
      height: size.height / 13,
      decoration: BoxDecoration(
          color: AppColors.primary,
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onTap,
        splashColor: AppColors.btnBorderColor,
        child: Center(
          child: Text(
            "Skip",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.07,
              fontFamily: 'Nexa Bold 650',
            ),
          ),
        ),
      ),
    );
  }
}
