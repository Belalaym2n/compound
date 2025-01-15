import 'package:flutter/material.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../utils/widgets.dart';
import '../../../ui/field.dart';
import '../../../ui/show_logo.dart';

class LoginItem extends StatefulWidget {
  LoginItem(
      {super.key,
      required this.passwordController,
      required this.login_button,
      required this.register_text,
      required this.emailController});

  TextEditingController emailController;
  TextEditingController passwordController;
  Widget login_button;
  Widget register_text;

  @override
  State<LoginItem> createState() => _LoginItemState();
}

class _LoginItemState extends State<LoginItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            showLogo(
                shoImage: true,
                screenWidth: Constants.screenWidth,
                name: 'Login',
                screenHeight: Constants.screenHeight),
            SizedBox(
              height: Constants.screenHeight * 0.08,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  EdgeInsets.symmetric(horizontal: Constants.screenWidth / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTitle("Email", Constants.screenWidth),
                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your Email",
                      iconData: Icons.person,
                      screenHeight: Constants.screenHeight,
                      screenWidth: Constants.screenWidth,
                      controller: widget.emailController,
                      obscureText: false),
                  SizedBox(
                    height: Constants.screenHeight / 50,
                  ),
                  customTitle("Password", Constants.screenWidth),
                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your password",
                      iconData: Icons.lock,
                      screenHeight: Constants.screenHeight,
                      screenWidth: Constants.screenWidth,
                      controller: widget.passwordController,
                      obscureText: true),
                  SizedBox(
                    height: Constants.screenHeight / 20,
                  ),
                  widget.login_button,
                  widget.register_text
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
