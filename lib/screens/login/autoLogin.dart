import 'package:flutter/cupertino.dart';
import 'package:qr_code/screens/admin_panel/admin_servises.dart';
import 'package:qr_code/screens/onBoardTwo/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_navigation/bottomNavigation.dart';
import '../security/scanQrCode/scanQrCode.dart';

class AutoLogin extends StatefulWidget {
  @override
  State<AutoLogin> createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
  late SharedPreferences sharedPreferences;

  bool isLogin = false;
  bool isAdmin = false;
  bool isSecurity = false;

  checkUserLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("Id") != null) {
      setState(() {
        isLogin = true;
      });
    }
    if (sharedPreferences.getBool('isAdmin') == true) {
      setState(() {
        isAdmin = true;
      });
    }
    if (sharedPreferences.getBool('is security') == true) {
      setState(() {
        isAdmin = true;
      });
    }
  }

  @override
  void initState() {
    checkUserLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isAdmin
        ? AdminServices()
        : isLogin
            ? const BottomNav()
            : isSecurity
                ? QRScanPage()
                : const OnBoard();
  }
}
