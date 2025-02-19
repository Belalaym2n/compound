import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/config/routes.dart';
import 'package:qr_code/data/services/auth_service/firebaseLoginService.dart';
import 'package:qr_code/ui/core/athentication/login/connector/login_connector.dart';
import 'package:qr_code/ui/core/athentication/login/view_model/view_model_login.dart';
import 'package:qr_code/ui/core/athentication/login/widgets/login_item.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/success_widget.dart';
import 'package:qr_code/utils/base.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../data/repositires/firebaseAuth/firebaseLoginRepo.dart';
import '../../../../../data/repositires/firebaseAuth/reset_password.dart';
import '../../../../../data/repositires/firebaseDatabseReo/getOwnersRepo.dart';
import '../../../../../data/services/ownerFirebaseDatabaseService/getOwners.dart';
import '../../../ui/sharedWidgets/checkIneternet.dart';
import '../../../ui/sharedWidgets/elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<ViewModelLogin, LoginScreen>
    implements LoginConnector {
  var emailController = TextEditingController();
  var emailControllerForResetPassword = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) => Consumer<ViewModelLogin>(
            builder: (context, viewModel, child) => InternetWrapper(
                child: LoginItem(
                    isDoneResetPassword: viewModel.isDoneResetPassword,
                    isLoading: viewModel.isLoading,
                    emailControllerForResetPassword:
                        emailControllerForResetPassword,
                    resetPassword: () async {
                      await viewModel.resetPassword(
                          context: context,
                          email: emailControllerForResetPassword.text);
                      emailController.clear();
                    },
                    obsureText: viewModel.obsureText,
                    changeObureText: viewModel.changeObsureText,
                    passwordController: passwordController,
                    login_button: elevated_button(
                        loading: viewModel.isLoading,
                        buttonName: 'Login',
                        onPressed: () {
                          viewModel.login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context);
                        }),
                    register_text: registerText(),
                    emailController: emailController))));
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
              style: TextStyle(fontSize: Constants.screenWidth * 0.04),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: Constants.screenWidth * 0.04),
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
    ResetPasswordRepo resetPasswordRepo = ResetPasswordRepo();
    FirebaseLoginService firebaseLoginService = FirebaseLoginService();
    FirebaseLoginRepo loginRepo = FirebaseLoginRepo(firebaseLoginService);
    FirebaseDatabaseGetOwnersService firebaseDatabaseGetOwnersService =
        FirebaseDatabaseGetOwnersService();
    FirebaseDatabaseGetOwnersRepo ownersDatabaseRepository =
        FirebaseDatabaseGetOwnersRepo(firebaseDatabaseGetOwnersService);

    // TODO: implement init_my_view_model
    return ViewModelLogin(
        resetPasswordRepo, ownersDatabaseRepository, loginRepo);
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

  @override
  successWidget() {
    // TODO: implement successWidget
    return success_widget(
        successMessage: "Please check your email messages",
        onNavigate: () {},
        context: context);
  }
}
