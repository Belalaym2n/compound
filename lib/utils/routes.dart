import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/admin_panel/add_user/add_users.dart';
import 'package:qr_code/screens/admin_panel/admin_servises.dart';
import 'package:qr_code/screens/admin_panel/getAllUsers/allUsersMessage.dart';
import 'package:qr_code/screens/for_sale/add/for_sale.dart';
import 'package:qr_code/screens/login/autoLogin.dart';
import 'package:qr_code/screens/notification_screen/notification_screen.dart';
import 'package:qr_code/screens/onBoard/onBoardPage.dart';

import '../screens/generateQRCode/creatQrCode.dart';
import '../screens/scanQrCode/scanQrCode.dart';
import '../screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String addUser = 'add';
  static const String adminService = '/sda';
  static const String generateQr = 'generatt';
  static const String allUserSent = '/sfs';
  static const String splash = '/';
  static const String autoLogin = 'auto';
  static const String forSale = 'for';
  static const String videoCall = 'video';
  static const String onBoard = 'onBoard';
  static const String notification = 'notifcation';
  static const String scanQrCode = '/scan';
}

class Routes {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.addUser:
        return MaterialPageRoute(
          builder: (context) => const AddUsers(),
        );
      case AppRoutes.notification:
        // return MaterialPageRoute(
        //   builder: (context) =>  NotificationScreen(),
        // );
      case AppRoutes.scanQrCode:
        return MaterialPageRoute(
          builder: (context) => QRScanPage(),
        );
      case AppRoutes.addUser:
        return MaterialPageRoute(
          builder: (context) => AutoLogin(),
        );
      case AppRoutes.onBoard:
        return MaterialPageRoute(
          builder: (context) => const OnBoardPage(),
        );
        ///
      case AppRoutes.forSale:
        return MaterialPageRoute(
          builder: (context) => const ForSale(),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => AnimatedSplashScreen(),
        );
      case AppRoutes.allUserSent:
        return MaterialPageRoute(
          builder: (context) => AllUsersSentMessage(),
        );
      case AppRoutes.adminService:
        return MaterialPageRoute(
          builder: (context) => AdminServices(),
        );
      case AppRoutes.generateQr:
        return MaterialPageRoute(
          builder: (context) => GeneratQrCode(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: const Text("error")),
              body: unDefinedRoute(),
            );
          },
        );
    }
  }

  static Widget unDefinedRoute() {
    return const Center(child: Text("Route Not Found"));
  }
}
