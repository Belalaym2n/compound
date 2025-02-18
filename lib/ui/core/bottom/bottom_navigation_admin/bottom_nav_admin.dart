import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/utils/app_colors.dart';

import 'bottom_nav_admin_view_mode.dart';

class BottomNavAdmin extends StatefulWidget {
  const BottomNavAdmin({super.key});

  @override
  State<BottomNavAdmin> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNavAdmin> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavAdminViewMod(),
      child: Consumer<BottomNavAdminViewMod>(
        builder: (context, viewModel, child) => Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
              height: 50,
              backgroundColor: Colors.transparent,
              color: AppColors.primary,
              animationDuration: const Duration(milliseconds: 500),
              onTap: (int index) {
                viewModel.updateIndex(index);
              },
              items: const [
                Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                ),
                Icon(
                  Icons.car_crash,
                  color: Colors.white,
                ),
                Icon(
                  Icons.qr_code_2,
                  color: Colors.white,
                ),
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ]),
          body: viewModel.pages[viewModel.selectedIndex],
        ),
      ),
    );
  }
}
