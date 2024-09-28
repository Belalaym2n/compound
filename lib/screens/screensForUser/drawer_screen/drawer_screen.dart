import 'package:flutter/material.dart';
import 'package:qr_code/utils/routes.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  double screenHeight = 0;

  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      height: screenHeight,
      width: screenWidth,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            logout(context),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            customerServices(context),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            stores_widget(context)
          ],
        ),
      ),
    );
  }

  Widget logout(BuildContext context) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.login);
        },
        child: Row(
          children: [
            Icon(
              Icons.logout,
              color: Colors.red,
              size: screenWidth * 0.06,
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
              ),
            )
          ],
        ),
      );

  Widget stores_widget(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.stores);
        },
        child: Row(
          children: [
            Icon(
              Icons.admin_panel_settings,
              color: Colors.red,
              size: screenWidth * 0.06,
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Text(
              'All Stores',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
              ),
            ),
          ],
        ));
  }

  Widget customerServices(BuildContext context) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.customer);
        },
        child: Row(
          children: [
            Icon(
              Icons.admin_panel_settings,
              color: Colors.red,
              size: screenWidth * 0.06,
            ),
            SizedBox(
              width: screenWidth * 0.03,
            ),
            Text(
               
              'Customer Services',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
              ),
            ),
          ],
        ),
      );
}
