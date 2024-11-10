import 'package:flutter/cupertino.dart';

import '../../screens_for_security/scanQrCode/scanQrCode.dart';
import '../orders/notifcation_service.dart';

class BottomNavAdminViewMod extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Widget> pages = [
    OrdersScreen(
      externalId: 'service',
    ),
    QRScanPage()
  ];
}
