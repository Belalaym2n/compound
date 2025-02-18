import 'package:flutter/cupertino.dart';
import 'package:qr_code/ui/core/user/Home_page/view/home_page.dart';

import '../../user/notification_screen/view/notification_screen.dart';

class BottomeNavViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Widget> pages = [
    const HomePage(),
    const NotificationScreen(),
    // GetCarWashBookingScreen(),
    // const AllOrdersScreen(),
    // // AddUsersValidated(),
  ];
}
