import 'package:flutter/cupertino.dart';

import '../../admin/add_users_validated/view/add_users_validated.dart';
import '../../admin/getAllBooking/get_car_wash_booking/view/get_car_wahs_booking_screen.dart';
import '../../admin/get_all_orders/view/all_orders_screen.dart';
import '../../admin/scanQrCode/scanQrCode.dart';

class BottomNavAdminViewMod extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Widget> pages = [
    AllOrdersScreen(),
    GetCarWashBookingScreen(),
    AddUsersValidated(),
    QRScanPage(),
  ];
}
