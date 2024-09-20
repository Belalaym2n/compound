import 'package:flutter/material.dart';
import 'package:qr_code/screens/screensForUser/customer_services/customer_services_screen.dart';

import '../screens/common_screen/Register/login/autoLogin.dart';
import '../screens/common_screen/Register/login/login_screen.dart';
import '../screens/common_screen/Register/sign_up/register_screen.dart';
import '../screens/common_screen/onBoardTwo/home_page.dart';
import '../screens/common_screen/splash_screen/splash_screen.dart';
import '../screens/screensForUser/bottom_navigation/bottomNavigation.dart';
import '../screens/screensForUser/generateQRCode/creatQrCode.dart';
import '../screens/screens_for_admin/add_for_rent/for_rent.dart';
import '../screens/screens_for_admin/admin_servises.dart';
import '../screens/screens_for_admin/getAllUsers/allUsersMessage.dart';
import '../screens/screens_for_ssecurity/scanQrCode/scanQrCode.dart';

class AppRoutes {
  static const String adminService = '/sda';
  static const String generateQr = 'generate';
  static const String register = 'register';
  static const String customer = 'customer';
  static const String allUserSent = '/sfs';
  static const String splash = '/';
  static const String autoLogin = 'auto';
  static const String login = 'login screen';
  static const String homePage = '/sf';
  static const String forSale = 'for';
  static const String videoCall = 'video';
  static const String onBoard = 'onBoard';
  static const String notification = 'notification';
  static const String scanQrCode = '/scan';
  static const String bottomNavigate = '/scan';
}

class Routes {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.bottomNavigate:
        return MaterialPageRoute(
          builder: (context) => const BottomNav(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case AppRoutes.customer:
        return MaterialPageRoute(
          builder: (context) => const CustomerServicesScreen(),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case AppRoutes.notification:
      // return MaterialPageRoute(
      //   builder: (context) =>  NotificationScreen(),
      // );
      case AppRoutes.scanQrCode:
        return MaterialPageRoute(
          builder: (context) => const QRScanPage(),
        );
      case AppRoutes.autoLogin:
        return MaterialPageRoute(
          builder: (context) => const AutoLogin(),
        );

      case AppRoutes.homePage:
        return MaterialPageRoute(
          builder: (context) => const OnBoard(),
        );

      ///
      case AppRoutes.forSale:
        return MaterialPageRoute(
          builder: (context) => const ForSale(),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => const AnimatedSplashScreen(),
        );
      case AppRoutes.allUserSent:
        return MaterialPageRoute(
          builder: (context) => const AllUsersSentMessage(),
        );
      case AppRoutes.adminService:
        return MaterialPageRoute(
          builder: (context) => const AdminServices(),
        );
      case AppRoutes.generateQr:
        return MaterialPageRoute(
          builder: (context) => const GeneratQrCode(),
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
