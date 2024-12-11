import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/athentication/login/view_model/view_model_login.dart';
import 'package:qr_code/ui/core/athentication/login/widgets/login_connector.dart';
import 'package:qr_code/ui/core/athentication/login/widgets/login_item.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';
import 'package:qr_code/utils/base.dart';
import 'package:qr_code/utils/routes.dart';

import '../../../ui/elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<ViewModelLogin, LoginScreen>
    implements LoginConnector {
  double screenHeight = 0;
  double screenWidth = 0;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return LoginItem(
        passwordController: passwordController,
        login_button: elevated_button(onPressed: () {
          viewModel.login(
              emailController: emailController.text.trim(),
              passwordController: passwordController.text.trim(),
              context: context);
        }),
        register_text: registerText(),
        emailController: emailController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  navigateAdmin() {
    return Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.bottomNavAdmin, (route) => false);
  }

  @override
  navigateUser() {
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
  navigateSecurity() {
    // TODO: implement navigateSecuirty
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.scanQrCode, (route) => false);
  }

  @override
  ViewModelLogin init_my_view_model() {
    // TODO: implement init_my_view_model
    return ViewModelLogin();
  }

  @override
  onError(String message) {
    return error_widget(context: context, message: message);
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    throw UnimplementedError();
  }
}
