import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

import '../athentication/login/widgets/autoLogin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _positionController;
  late AnimationController _opacityController;
  late AnimationController _textOpacityController;
  late Animation<double> _positionAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _textOpacityAnimation;
  bool showFinalScreen = false;

  @override
  void initState() {
    super.initState();

    // تأخير للانتقال من الشاشة البيضاء إلى الشاشة الثانية
    Timer(Duration(seconds: 0), () {
      setState(() {
        showFinalScreen = true;

        // بدء الرسوم المتحركة للشعار في الشاشة الثانية
        _positionController.forward();
        _opacityController.forward();
      });

      // بدء ظهور النص بعد انتهاء حركة الشعار
      Timer(Duration(seconds: 2), () {
        _textOpacityController.forward();
      });
    });

    // إعداد الحركة العمودية
    _positionController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _positionAnimation = Tween<double>(begin: 0, end: 326).animate(
      CurvedAnimation(parent: _positionController, curve: Curves.easeOut),
    );

    // إعداد الشفافية للظهور التدريجي
    _opacityController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _opacityController, curve: Curves.easeIn),
    );

    // إعداد الشفافية للنص
    _textOpacityController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textOpacityController, curve: Curves.easeIn),
    );

    // الانتقال إلى الشاشة الرئيسية بعد انتهاء الشاشة الثانية
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AutoLogin()),
      );
    });
  }

  @override
  void dispose() {
    _positionController.dispose();
    _opacityController.dispose();
    _textOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constants.initSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // الشعار المتحرك في الشاشة الثانية
          if (showFinalScreen)
            AnimatedBuilder(
              animation: _positionController,
              builder: (context, child) {
                return Positioned(
                  bottom: _positionAnimation.value,
                  left: MediaQuery.of(context).size.width / 2.3 - 75,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: Container(
                      width: Constants.screenWidth * 0.5,
                      height: Constants.screenHeight * 0.2,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/MAS-Logo.png', // ضع مسار الصورة هنا
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          // النص المتحرك بتأثير fade in بعد ظهور الشعار
          if (showFinalScreen)
            Center(
              child: FadeTransition(
                opacity: _textOpacityAnimation,
                child: Padding(
                  padding: EdgeInsets.only(top: Constants.screenHeight * 0.18),
                  child: Text(
                    "خدمتك بسهوله", // النص الذي تريد عرضه
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: Constants.screenWidth * 0.082,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
