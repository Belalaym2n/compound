import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/login/login_connector.dart';
import 'package:qr_code/screens/login/view_model_login.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';
import 'package:qr_code/utils/routes.dart';
import 'package:qr_code/utils/widgets.dart';

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
  ViewModelLogin viewModel = ViewModelLogin();
  bool isLogin = false;

  @override
  void initState() {
    viewModel.loginConnector = this;
    // TODO: implement initState
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) => SingleChildScrollView(
          child: Column(
            children: [
              showLogo(),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              SizedBox(
                height: screenHeight / 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTitle("Owner ID", screenWidth),
                    SizedBox(
                      height: screenHeight / 70,
                    ),
                    customFormField(
                        hintText: "Enter your ID",
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
                    login_button()
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
            viewModel.checkUserExist(
                id: id, password: password, context: context);
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

  Widget showLogo() => Container(
        height: screenHeight / 2.5,
        width: screenWidth,
        decoration: BoxDecoration(
          color: AppColors.primary,
          //color: primaryNew,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(70),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: ImageIcon(
                const AssetImage(AppImages.logoImage),
                size: screenWidth * 50,
                color: Colors.white,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.18,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth / 14,
                        fontFamily: 'Nexa Bold 650'),
                  ),
                ],
              ),
            ),
          ],
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
  naviget(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.adminService, (route) => false);
  }

  @override
  navigateUser(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.bottomNavigate, (route) => false);
  }

  @override
  navigateSecuirty(BuildContext context) {
    // TODO: implement navigateSecuirty
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.scanQrCode, (route) => false);
  }
}
