import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/widgets.dart';
import '../../../ui/field.dart';
import '../../../ui/show_logo.dart';

class SignUpItem extends StatefulWidget {
  SignUpItem({
    super.key,
    required this.passwordController,
    required this.compoundName,
    required this.emailController,
    required this.register_button,
    required this.nameController,
    required this.isExpanded,
    required this.changeExpanded,
    required this.addressController,
    required this.changeValue,
    required this.changeIndex,
    required this.selectedCompoundIndex,
  });

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController addressController;
  TextEditingController passwordController;
  Widget register_button;
  bool isExpanded;
  Function changeExpanded;
  Function changeValue;
  Function changeIndex;
  String compoundName;
  int selectedCompoundIndex;

  @override
  State<SignUpItem> createState() => _SignUpItemState();
}

// لتحديد الـ Compound المختار

final List<String> compounds = [
  "Madinate el galala",
  "LA Mirada",
  "Maadi",
  "koronfol",
];

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
            showLogo(
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
                  customTitle("Password", Constants.screenWidth),
                  SizedBox(
                    height: Constants.screenHeight / 160,
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
                    height: Constants.screenHeight / 160,
                  ),
                  customFormField(
                      hintText: "Enter your address",
                      iconData: Icons.lock,
                      screenHeight: Constants.screenHeight,
                      screenWidth: Constants.screenWidth,
                      controller: widget.addressController,
                      obscureText: true),
                  // choose_rule(),
                  SizedBox(
                    height: Constants.screenHeight / 70,
                  ),
                  chooseRule(),
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

  Widget chooseRule() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: widget.isExpanded
          ? Constants.screenHeight * 0.35
          : Constants.screenHeight * 0.08,
      width: Constants.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Constants.screenHeight * 0.02,
                  horizontal: Constants.screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose Compound",
                    style: TextStyle(
                      fontSize: Constants.screenWidth * 0.045,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.changeExpanded();
                    },
                    child: AnimatedRotation(
                      turns: widget.isExpanded ? 0.5 : 0,
                      // Rotation animation for arrow
                      duration: Duration(milliseconds: 300),
                      child: Icon(
                        widget.isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.primary,
                        size: Constants.screenWidth * 0.07,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded Content
            AnimatedOpacity(
              opacity: widget.isExpanded ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: widget.isExpanded
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.screenWidth * 0.05,
                          vertical: Constants.screenHeight * 0.01),
                      child: Column(
                        children: compounds
                            .asMap()
                            .entries
                            .map((entry) =>
                                buildCompoundItem(entry.key, entry.value))
                            .toList(),
                      ),

                      // Dynamically pass the rule widget
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCompoundItem(int index, String compoundName) {
    final bool isSelected = index == widget.selectedCompoundIndex;

    return GestureDetector(
      onTap: () {
        widget.changeIndex(index);
        widget.changeValue(compoundName);
        print(compoundName); // تحديث العنصر المختار
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Constants.screenHeight * 0.01),
        height: Constants.screenHeight * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          compoundName,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: Constants.screenWidth * 0.04,
          ),
        ),
      ),
    );
  }
}
