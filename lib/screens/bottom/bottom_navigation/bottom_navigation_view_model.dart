import 'package:flutter/cupertino.dart';
import 'package:qr_code/ui/core/add_users_validated/widgets/add_users_validated.dart';

import '../../../ui/core/Home_page/widgets/home_page.dart';
import '../../../ui/core/get_all_orders/widget/all_orders_screen.dart';
import '../../../ui/core/notification_screen/widgets/notification_screen.dart';

class BottomeNavViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Widget> pages = [
    const HomePage(),
    NotificationScreen(),
    const AllOrdersScreen(),
    AddUsersValidated(),
  ];
}
