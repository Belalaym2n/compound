import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/admin_panel/add_users.dart';
import 'package:qr_code/screens/login/autoLogin.dart';
import 'package:qr_code/screens/login/login_screen.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isTextVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward().then((_) {
      // Delay the start of text animation and show static image
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isTextVisible = true;
        });
      });

      // Navigate to the next screen after the text animation
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AutoLogin()),
              (route) => false,
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(height: screenHeight*0.14),
            Center(
              child: Column(
                children: [
                  // Animated Image
                  Visibility(
                    visible: !_isTextVisible,
                    child: RotationTransition(
                      turns: _animation,
                      child: FadeTransition(
                        opacity: _animation,
                        child: ScaleTransition(
                          scale: _animation,
                          child: Image.asset(AppImages.logoImage,
                            height: screenHeight*0.57,fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Visibility(
                          visible: _isTextVisible,
                          child: Image.asset(AppImages.logoImage,height:  screenHeight*0.57,fit: BoxFit.cover,)
                      ),
                      // SText Animation

                      Column(
                        children: [
                          SizedBox(
                            height: screenHeight*0.38,
                          ),
                          Visibility(
                            visible: _isTextVisible,
                            child: Center(
                              child: AnimatedTextKit(
                                onTap: () {
                                  initState();
                                },

                                animatedTexts: [


                                  TyperAnimatedText(   "Welcome To Qr Code App",
                                textStyle:  const TextStyle(
                                    color: Colors.white,fontSize: 23,
                                    fontWeight: FontWeight.w900),

                                                            ),

                                ],

                                totalRepeatCount: 1,

                              ),
                                ),
                              ),


                        ],
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
