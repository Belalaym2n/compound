import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/services/shared_pref_helper.dart';
import '../../../admin/scanQrCode/scanQrCode.dart';
import '../../../bottom/bottom_navigation/bottomNavigation.dart';
import '../../../onBoard/onBaoar.dart';

class AutoLogin extends StatefulWidget {
  const AutoLogin({super.key});

  @override
  State<AutoLogin> createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
  late SharedPreferences sharedPreferences;

  bool isUser = false;
  bool isAdmin = false;
  bool isSecurity = false;

  checkUserLogin() async {
    print(isUser);
    if (SharedPreferencesHelper.getData("user") == true) {
      setState(() {
        print(isUser);
        isUser = true;
      });
    }
    if (SharedPreferencesHelper.getData("admin") == true) {
      setState(() {
        isAdmin = true;
      });
    }
    if (SharedPreferencesHelper.getData("security") == true) {
      setState(() {
        isSecurity = true;
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
        ? Container()
        : isUser
            ? const BottomNav()
            : isSecurity
                ? QRScanPage()
                : const OnBoard();
  }
}
