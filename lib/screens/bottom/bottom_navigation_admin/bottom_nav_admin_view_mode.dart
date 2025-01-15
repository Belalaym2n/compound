import 'package:flutter/cupertino.dart';

import '../../../ui/core/add_users_validated/widgets/add_users_validated.dart';
import '../../../ui/core/orders/widgets/notifcation_service.dart';
import '../../../ui/core/qr_code/scanQrCode/scanQrCode.dart';

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
    const AddUsersValidated(),
    QRScanPage(),
  ];
}
