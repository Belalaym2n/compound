import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/widgets.dart';
import '../../../ui/show_logo.dart';

class SignUpItem extends StatefulWidget {
  SignUpItem({
    super.key,
    required this.passwordController,
    required this.emailController,
    required this.register_button,
    required this.nameController,
    required this.addressController,
  });

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController addressController;
  TextEditingController passwordController;
  Widget register_button;

  @override
  State<SignUpItem> createState() => _SignUpItemState();
}

class _SignUpItemState extends State<SignUpItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            showLogo(
                screenWidth: Constants.screenWidth,
                screenHeight: Constants.screenHeight * 0.8,
                name: 'Sign UP'),
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  EdgeInsets.symmetric(horizontal: Constants.screenWidth / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),
                  customTitle("Name", Constants.screenWidth),
                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your name",
                      iconData: Icons.person,
                      screenHeight: Constants.screenHeight,
                      screenWidth: Constants.screenWidth,
                      controller: widget.nameController,
                      obscureText: false),
                  SizedBox(
                    height: Constants.screenHeight / 50,
                  ),
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
                    height: Constants.screenHeight / 70,
                  ),
                  customTitle("Address", Constants.screenWidth),
                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your address",
                      iconData: Icons.lock,
                      screenHeight: Constants.screenHeight,
                      screenWidth: Constants.screenWidth,
                      controller: widget.addressController,
                      obscureText: true),
                  SizedBox(
                    height: Constants.screenHeight / 30,
                  ),
                  widget.register_button,
                  SizedBox(
                    height: Constants.screenHeight / 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
