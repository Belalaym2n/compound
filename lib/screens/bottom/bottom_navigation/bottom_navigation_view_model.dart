import 'package:flutter/cupertino.dart';

import '../../../ui/core/Home_page/widgets/home_page.dart';
import '../../../ui/core/get_all_forRent/widgets/get_all_for_rent.dart';
import '../../../ui/core/get_all_orders/all_orders.dart';
import '../../../ui/core/notification_screen/getAllNotifcation.dart';

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
    OrderScreen(),
    GetAllNotifications(),
  ];
}
