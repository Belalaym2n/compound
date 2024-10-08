import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens_for_admin/notification_order/notifcation_service.dart';
import '../Home_page/home_page.dart';
import '../generateQRCode/creatQrCode.dart';
import '../get_all_forRent/get_all_for_rent.dart';
import '../notification_screen/getAllNotifcation.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePage homepage;
  late NotificationOrderScreen notificationOrder;
  late GetAllAdv getAllAdv;

  //late  Profile profile;
  late GeneratQrCode qrCode;
  late GetAllNotifications notifications;
  String? name;
  SharedPreferences? sharedPreferences;

  getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences?.getString("name");
    setState(() {});
    return name;
  }

  @override
  void initState() {
    _initialize();

    setState(() {
      homepage = const HomePage();
      notifications = const GetAllNotifications();
      notificationOrder = NotificationOrderScreen(
        externalId: 'service',
      );
      getAllAdv = const GetAllAdv();
      qrCode = const GeneratQrCode();
      pages = [homepage, notificationOrder, qrCode, getAllAdv, notifications];
    });
    super.initState();
  }

  Future<void> _initialize() async {
    await getUser();
    setState(() {
      homepage = const HomePage();
      notificationOrder = NotificationOrderScreen(
        externalId: 'service',
      );

      qrCode = const GeneratQrCode();
      pages = [homepage, notificationOrder, qrCode, getAllAdv, notifications];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.transparent,
          color: AppColors.primary,
// animationCurve: Curves.fastOutSlowIn,

          animationDuration: const Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.chat,
              color: Colors.white,
            ),
            Icon(
              Icons.qr_code_2,
              color: Colors.white,
            ),
            Icon(
              Icons.real_estate_agent,
              color: Colors.white,
            ),
            Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
