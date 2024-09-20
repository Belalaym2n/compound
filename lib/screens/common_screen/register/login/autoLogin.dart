import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../screensForUser/bottom_navigation/bottomNavigation.dart';
import '../../../screens_for_admin/admin_servises.dart';
import '../../../screens_for_ssecurity/scanQrCode/scanQrCode.dart';
import '../../onBoardTwo/home_page.dart';

class AutoLogin extends StatefulWidget {
  const AutoLogin({super.key});

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
    if (sharedPreferences.getString("name") != null) {
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
        ? const AdminServices()
        : isLogin
            ? const BottomNav()
            : isSecurity
                ? const QRScanPage()
                : const OnBoard();
  }
}
