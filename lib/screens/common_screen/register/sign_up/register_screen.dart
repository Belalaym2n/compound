import 'package:flutter/material.dart';
import 'package:qr_code/screens/common_screen/register/sign_up/register_connector.dart';
import 'package:qr_code/screens/common_screen/register/sign_up/register_screen_view_model.dart';
import 'package:qr_code/utils/routes.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/widgets.dart';
import '../widget_register.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterConnector {
  double screenHeight = 0;

  double screenWidth = 0;

  bool isRegister = false;

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    viewModel.connector = this;
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            showLogo(
                screenWidth: screenWidth,
                screenHeight: screenHeight * 0.8,
                name: 'Sign UP'),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight / 70,
                  ),
                  customTitle("Name", screenWidth),
                  SizedBox(
                    height: screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your name",
                      iconData: Icons.person,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      controller: nameController,
                      obscureText: false),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  customTitle("Email", screenWidth),
                  SizedBox(
                    height: screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your Email",
                      iconData: Icons.person,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      controller: emailController,
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
                    height: screenHeight / 70,
                  ),
                  customTitle("Address", screenWidth),
                  SizedBox(
                    height: screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your address",
                      iconData: Icons.lock,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      controller: addressController,
                      obscureText: true),
                  SizedBox(
                    height: screenHeight / 30,
                  ),
                  register_button(
                      context: context,
                      password: passwordController.text,
                      email: emailController.text)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget register_button({
    required String email,
    required String password,
    required BuildContext context,
  }) =>
      Align(
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
            setState(() {
              isRegister = false;
            });
            viewModel.createUser(
                name: nameController.text,
                address: addressController.text,
                email: email,
                password: password,
                context: context);
          },
          child: isRegister
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth / 15,
                    fontFamily: 'Nexa Bold 650',
                  ),
                ),
        ),
      );

  @override
  Future errorMessage(String error, BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18)),
        content: Text(error),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18)))
        ],
      ),
    );
  }

  @override
  navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
    // TODO: implement navigateToLogin
    throw UnimplementedError();
  }
}
