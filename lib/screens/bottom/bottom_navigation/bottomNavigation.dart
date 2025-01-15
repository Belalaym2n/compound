import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/utils/app_colors.dart';

import 'bottom_navigation_view_model.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomeNavViewModel(),
      child: Consumer<BottomeNavViewModel>(
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
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                // Icon(
                //   Icons.home_repair_service_outlined,
                //   color: Colors.white,
                // ),
                Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                ),
                Icon(
                  Icons.people_alt_outlined,
                  color: Colors.white,
                ),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ]),
          body: viewModel.pages[viewModel.selectedIndex],
        ),
      ),
    );
  }
}
