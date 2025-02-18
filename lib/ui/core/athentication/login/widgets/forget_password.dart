import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/elevated_button.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/shared_widgets.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController emailController;

  bool isLoading;
  bool isDoneResetPassword;
  Function resetPassword;

  ForgotPasswordScreen(
      {required this.emailController,
      required this.isLoading,
      required this.isDoneResetPassword,
      required this.resetPassword});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: servic_name(serviceName: "Forget Password"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(Constants.screenWidth * 0.051),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.1),
              // Icon or Illustration
              Center(
                child: Icon(
                  Icons.lock_reset_rounded,
                  size: Constants.screenWidth * 0.25,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: Constants.screenHeight * 0.02),
              // Title and Instructions
              Center(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: Constants.screenWidth * 0.056,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: Constants.screenHeight * 0.01),
              Center(
                child: Text(
                  "Enter your email address to receive a reset link.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Constants.screenWidth * 0.04,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              // Email Input Field
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.screenWidth * 0.05),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: size.height * 0.04),

              elevated_button(
                  loading: isLoading,
                  onPressed: () {
                    resetPassword();
                  },
                  buttonName: 'Reset password'),
              SizedBox(height: Constants.screenHeight * 0.021),
              // Back to Login
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back to Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Constants.screenWidth * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
