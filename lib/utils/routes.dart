import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/admin_panel/add_users.dart';
import 'package:qr_code/screens/admin_panel/admin_servises.dart';
import 'package:qr_code/screens/admin_panel/getAllUsers/allUsersMessage.dart';
import 'package:qr_code/screens/chat/chat_screen.dart';
import 'package:qr_code/screens/login/autoLogin.dart';

import '../screens/generateQRCode/creatQrCode.dart';
import '../screens/scanQrCode/scanQrCode.dart';
import '../screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String addUser = 'add';
  static const String adminService = '/';
  static const String generateQr = 'generatt';
  static const String allUserSent = '/sfs';
  static const String splash = 'sdf/';
  static const String autoLogin = 'auto';
  static const String scanQrCode = '/scan';
}

class Routes {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.addUser:
        return MaterialPageRoute(
          builder: (context) => const AddUsers(),
        );
      case AppRoutes.scanQrCode:
        return MaterialPageRoute(
          builder: (context) => QRScanPage(),
        );
      case AppRoutes.addUser:
        return MaterialPageRoute(
          builder: (context) => AutoLogin(),
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
