import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qr_code/utils/app_colors.dart';

import '../../../../domain/models/owner_login.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  int _selectedIndex = -1;
  String? name;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    OwnerDetails ownerDetails = OwnerDetails();
    String? retrievedName = await ownerDetails.getUserName();
    setState(() {
      name = retrievedName;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: const Color(0xFFF5F5F5), // خلفية فاتحة ومريحة للعين
      height: screenHeight,

      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 700),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                SizedBox(height: screenHeight * 0.04),
                drawerData(
                    name: "My profile",
                    icon: Icons.people,
                    iconColor: AppColors.primary),
                SizedBox(height: screenHeight * 0.04),
                drawerData(
                    name: "My Orders",
                    icon: Icons.shopping_cart,
                    iconColor: AppColors.primary),
                SizedBox(height: screenHeight * 0.04),
                drawerData(
                    icon: Icons.settings,
                    name: "Settings",
                    iconColor: AppColors.primary),
                SizedBox(height: screenHeight * 0.04),
                drawerData(
                    widgetIcon: icon_widget(icon: Icons.login_outlined),
                    name: "Logout",
                    iconColor: Colors.red),
                SizedBox(height: screenHeight * 0.04),
                drawerData(
                  name: "Close",
                  iconColor: Colors.red,
                  widgetIcon: icon_widget(icon: Icons.close),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  icon_widget({required IconData icon}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: Icon(
        textDirection: TextDirection.ltr,
        weight: 23,
        icon,
        color: Colors.white,
        size: screenWidth * 0.05,
      ),
    );
  }

  Widget drawerData({
    IconData? icon,
    required String name,
    required Color iconColor,
    Widget? widgetIcon,
  }) {
    return Row(
      children: [
        icon != null
            ? Icon(
                icon,
                size: screenWidth * 0.07,
                color: iconColor,
              )
            : widgetIcon!,
        SizedBox(width: screenWidth * 0.05),
        Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.045,
          ),
        ),
      ],
    );
  }
}
