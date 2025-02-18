import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/config/routes.dart';
import 'package:qr_code/data/services/auth_service/registerService.dart';
import 'package:qr_code/ui/core/athentication/sign_up/connector/register_connector.dart';
import 'package:qr_code/ui/core/athentication/sign_up/widgets/sign_up_item.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/elevated_button.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/success_widget.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/firebaseAuth/creat_account.dart';
import '../../../../../data/repositires/firebaseDatabseReo/uploadOwnrRepo.dart';
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) => Consumer<RegisterViewModel>(
              builder: (context, viewModel, child) => SignUpItem(
                changeExpanded: viewModel.changeExpanded,
                changeObureText: viewModel.changeObsureText,
                changeCompoundIndex: viewModel.changeCompoundIndex,
                selectedCompoundIndex: viewModel.selectIndex,
                changeCompoundName: viewModel.changeCompoundName,
                obsureText: viewModel.obsureText,
                isExpanded: viewModel.isExpanded,
                passwordController: passwordController,
                emailController: emailController,
                addressController: addressController,
                nameController: nameController,
                register_button: elevated_button(
                    loading: viewModel.isLoading,
                    buttonName: 'Sign Up',
                    onPressed: () async {
                      try {
                        await viewModel.createUser(
                            name: nameController,
                            address: addressController,
                            email: emailController,
                            password: passwordController,
                            context: context);
                      } catch (e) {
                        print(e);
                      }
                    }),
              ),
            ));
  }

  @override
  navigateToLogin() {
    Navigator.pushNamed(context, AppRoutes.login);
    // TODO: implement navigateToLogin
  }

  @override
  RegisterViewModel init_my_view_model() {
    FirebaseRegisterService firebaseRegisterService = FirebaseRegisterService();

    FirebaseRegisterRepository authRepository =
        FirebaseRegisterRepository(firebaseRegisterService);
    OwnersAuthDatabaseRepository databaseRepository =
        OwnersAuthDatabaseRepository();
    // TODO: implement init_my_view_model
    return RegisterViewModel(authRepository, databaseRepository);
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

  @override
  success() {
    // TODO: implement success
    return success_widget(
        successMessage: "Create account success",
        onNavigate: navigateToLogin,
        context: context);
  }
}
