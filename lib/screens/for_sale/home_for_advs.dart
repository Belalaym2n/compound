import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/for_sale/get_all_advs/getAllAdv.dart';

import '../../utils/app_images.dart';
import '../../utils/routes.dart';
import '../admin_panel/add_user/add_users.dart';
import '../admin_panel/getAllUsers/allUsersMessage.dart';
import '../admin_panel/widget.dart';

class HomeForAdvs extends StatefulWidget {
  const HomeForAdvs({super.key});

  @override
  State<HomeForAdvs> createState() => _HomeForAdvsState();
}
double screenHeight = 0;
double screenWidth = 0;
class _HomeForAdvsState extends State<HomeForAdvs> {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          itemWidger(
              image: AppImages.addUser,
              functionNavigate: () {
                Navigator.of(context).pushNamed(AppRoutes.forSale);
              },
              screenHeight: screenHeight * 0.1,
              text: 'Add adv',
              screenWidth: screenWidth),
          itemWidger(
              image: AppImages.addUser,
              functionNavigate: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GetAllAdv(),
                ));
              },
              screenHeight: screenHeight * 0.1,
              text: 'All adv',
              screenWidth: screenWidth),
        ],
      ),
    );
  }
}
