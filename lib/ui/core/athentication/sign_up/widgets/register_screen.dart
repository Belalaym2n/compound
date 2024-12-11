import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/athentication/sign_up/widgets/register_connector.dart';
import 'package:qr_code/ui/core/athentication/sign_up/widgets/sign_up_item.dart';
import 'package:qr_code/ui/core/ui/elevated_button.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';
import 'package:qr_code/utils/base.dart';
import 'package:qr_code/utils/routes.dart';

import '../view_model/register_screen_view_model.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseView<RegisterViewModel, RegisterScreen>
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
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SignUpItem(
      passwordController: passwordController,
      emailController: emailController,
      addressController: addressController,
      nameController: nameController,
      register_button: elevated_button(onPressed: () {
        viewModel.createUser(
            name: nameController.text.trim(),
            address: addressController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            context: context);
      }),
    );
  }

  @override
  navigateToLogin() {
    Navigator.pushNamed(context, AppRoutes.login);
    // TODO: implement navigateToLogin
    throw UnimplementedError();
  }

  @override
  RegisterViewModel init_my_view_model() {
    // TODO: implement init_my_view_model
    return RegisterViewModel();
  }

  @override
  onError(String message) {
    // TODO: implement onError
    return error_widget(context: context, message: message);
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    throw UnimplementedError();
  }
}
