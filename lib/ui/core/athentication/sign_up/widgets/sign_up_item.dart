import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/athentication/sign_up/widgets/chooseCompoundWidget.dart';

import '../../../../../utils/constants.dart';
import '../../../ui/sharedWidgets/customerFormField.dart';
import '../../../ui/sharedWidgets/show_logo.dart';
import 'customTittle.dart';

class SignUpItem extends StatefulWidget {
  SignUpItem({
    super.key,
    required this.passwordController,
    required this.changeObureText,
    required this.emailController,
    required this.register_button,
    required this.nameController,
    required this.isExpanded,
    required this.changeExpanded,
    required this.addressController,
    required this.changeCompoundName,
    required this.changeCompoundIndex,
    required this.obsureText,
    required this.selectedCompoundIndex,
  });

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController addressController;
  TextEditingController passwordController;
  Widget register_button;
  bool isExpanded;
  bool obsureText;
  Function changeObureText;
  Function changeExpanded;
  Function changeCompoundName;
  Function changeCompoundIndex;
  int selectedCompoundIndex;

  @override
  State<SignUpItem> createState() => _SignUpItemState();
}

class _SignUpItemState extends State<SignUpItem> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showMasLogo(
                context: context,
                shoImage: false,
                screenWidth: Constants.screenWidth,
                screenHeight: Constants.screenHeight * 0.45,
                name: 'Sign Up'),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.screenWidth / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Constants.screenHeight / 40,
                  ),
                  customTitle("Name", Constants.screenWidth),
                  SizedBox(
                    height: Constants.screenHeight / 160,
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
                    height: Constants.screenHeight / 160,
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
                  customTitle("Address", Constants.screenWidth),
                  SizedBox(
                    height: Constants.screenHeight / 160,
                  ),
                  customFormField(
                      hintText: "Enter your address",
                      iconData: Icons.lock,
                      screenHeight: Constants.screenHeight,
                      screenWidth: Constants.screenWidth,
                      controller: widget.addressController,
                      obscureText: false),
                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),

                  // choose_rule(),
                  customTitle("Password", Constants.screenWidth),
                  SizedBox(
                    height: Constants.screenHeight / 160,
                  ),
                  customFormField(
                      changeObscureText: true,
                      hintText: "Enter your password",
                      iconData: Icons.lock,
                      changeViewOfPassword: widget.changeObureText,
                      screenHeight: Constants.screenHeight,
                      screenWidth: Constants.screenWidth,
                      controller: widget.passwordController,
                      obscureText: widget.obsureText),

                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),
                  ChooseCompound(
                      changeExpanded: widget.changeExpanded,
                      changeCompoundName: widget.changeCompoundName,
                      changeIndex: widget.changeCompoundIndex,
                      selectedCompoundIndex: widget.selectedCompoundIndex,
                      isExpanded: widget.isExpanded),
                  SizedBox(
                    height: Constants.screenHeight / 30,
                  ),
                  widget.register_button,
                  SizedBox(
                    height: Constants.screenHeight * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
