import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/common_screen/Register/login/view_model_login.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/widgets.dart';
import '../widget_register.dart';
import 'login_connector.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginConnector {
  double screenHeight = 0;
  double screenWidth = 0;
  var iDController = TextEditingController();
  var passwordController = TextEditingController();
  ViewModelLogin viewModelLogin = ViewModelLogin();
  bool isLogin = false;

  bool isLoading = false;

  @override
  void initState() {
    viewModelLogin.loginConnector = this;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => viewModelLogin,
        builder: (context, child) => SingleChildScrollView(
          child: Column(
            children: [
              showLogo(
                  screenWidth: screenWidth,
                  name: 'Login',
                  screenHeight: screenHeight),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTitle("Email", screenWidth),
                    SizedBox(
                      height: screenHeight / 70,
                    ),
                    customFormField(
                        hintText: "Enter your Email",
                        iconData: Icons.person,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        controller: iDController,
                        obscureText: false),
                    SizedBox(
                      height: screenHeight / 50,
                    ),
                    customTitle("Password", screenWidth),
                    SizedBox(
                      height: screenHeight / 70,
                    ),
                    customFormField(
                        hintText: "Enter your password",
                        iconData: Icons.lock,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        controller: passwordController,
                        obscureText: true),
                    SizedBox(
                      height: screenHeight / 20,
                    ),
                    login_button(),
                    registerText()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget login_button() => Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(screenWidth, screenHeight / 15),
            backgroundColor: AppColors.primary,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () async {
            String id = iDController.text.trim();
            String password = passwordController.text.trim();
            viewModelLogin.login(
                emailController: id,
                passwordController: password,
                context: context);
            setState(() {
              isLogin = true;
            });
            isLogin = true;
          },
          child: isLogin
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth / 15,
                    fontFamily: 'Nexa Bold 650',
                  ),
                ),
        ),
      );

  @override
  errorMessage(String error, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(error),
        title: const Text('error'),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    AppColors.primary), // AppColors.primary
              ),
              onPressed: () {
                setState(() {
                  isLogin = false;
                });
                isLogin = false;
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  @override
  navigateAdmin(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.bottomNavAdmin, (route) => false);
  }

  @override
  navigateUser(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.bottomNavigate, (route) => false);
  }

  Widget registerText() => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have account?",
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ))
          ],
        ),
      );

  @override
  navigateSecurity(BuildContext context) {
    // TODO: implement navigateSecuirty
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.scanQrCode, (route) => false);
  }
}
