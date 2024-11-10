import 'package:flutter/cupertino.dart';
import 'package:qr_code/screens/screensForUser/get_all_orders/all_orders.dart';

import '../Home_page/home_page.dart';
import '../get_all_forRent/get_all_for_rent.dart';
import '../notification_screen/getAllNotifcation.dart';

class BottomeNavViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Widget> pages = [
    const HomePage(),

    // CustomerServicesScreen(),
    const GetAllAdv(),
    const GetAllNotifications(),
    OrderScreen(),
  ];
}
