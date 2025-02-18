import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code/ui/core/athentication/sign_up/widgets/customTittle.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../ui/sharedWidgets/customerFormField.dart';
import '../../../ui/sharedWidgets/show_logo.dart';
import 'forget_password.dart';

class LoginItem extends StatefulWidget {
  LoginItem(
      {super.key,
      required this.passwordController,
      required this.login_button,
      required this.register_text,
      required this.obsureText,
      required this.emailControllerForResetPassword,
      required this.changeObureText,
      required this.isLoading,
      required this.resetPassword,
      required this.isDoneResetPassword,
      required this.emailController});

  TextEditingController emailController;
  TextEditingController emailControllerForResetPassword;
  TextEditingController passwordController;
  Widget login_button;
  Widget register_text;
  bool obsureText;
  bool isDoneResetPassword;
  bool isLoading;
  Function changeObureText;
  Function resetPassword;

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
            showMasLogo(
                shoImage: true,
                screenWidth: Constants.screenWidth,
                name: 'Login',
                screenHeight: Constants.screenHeight),
            SizedBox(
              height: Constants.screenHeight * 0.04,
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
                      changeObscureText: true,
                      changeViewOfPassword: widget.changeObureText,
                      obscureText: widget.obsureText),
                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(
                                  emailController:
                                      widget.emailControllerForResetPassword,
                                  isLoading: widget.isLoading,
                                  isDoneResetPassword:
                                      widget.isDoneResetPassword,
                                  resetPassword: widget.resetPassword,
                                ),
                              ));
                        },
                        child: forget_password()),
                  ),
                  SizedBox(
                    height: Constants.screenHeight / 30,
                  ),
                  widget.login_button,
                  widget.register_text,
                  contactWithAdmin(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  contactWithAdmin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWidget(
          IconButton(
            icon: Icon(Icons.call, color: Colors.white),
            onPressed: () {
              // Add call functionality here
            },
          ),
        ),
        SizedBox(
          width: Constants.screenWidth * 0.03,
        ),
        iconWidget(IconButton(
          icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
          onPressed: () {
            // Add LinkedIn functionality here
          },
        )),
        SizedBox(
          width: Constants.screenWidth * 0.03,
        ),
        iconWidget(
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
            onPressed: () {
              // Add Facebook functionality here
            },
          ),
        )
      ],
    );
  }

  iconWidget(IconButton iconButton) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
      ),
      child: iconButton,
    );
  }

  forget_password() {
    return Text(
      textAlign: TextAlign.right,
      "Forget Password",
      style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
          fontSize: Constants.screenWidth * 0.04),
    );
  }
}
