import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/user/addProblem/view/addProblemScreen.dart';

import '../ui/core/admin/orders/widgets/notifcation_service.dart';
import '../ui/core/admin/scanQrCode/scanQrCode.dart';
import '../ui/core/athentication/login/view/login_screen_.dart';
import '../ui/core/athentication/login/widgets/autoLogin.dart';
import '../ui/core/athentication/sign_up/view/register_screen.dart';
import '../ui/core/bottom/bottom_navigation/bottomNavigation.dart';
import '../ui/core/bottom/bottom_navigation_admin/bottom_nav_admin.dart';
import '../ui/core/onBoard/onBaoar.dart';
import '../ui/core/splash_screen/splash_screen.dart';
import '../ui/core/user/Home_page/widgets/home_page_item.dart';
import '../ui/core/user/generateQRCode/view/creatQrCode.dart';

class AppRoutes {
  static const String adminService = '/sda';
  static const String generateQr = 'generate';
  static const String register = 'register';
  static const String customer = 'customer';
  static const String bottomNavAdmin = 'efs/';
  static const String splash = '/';
  static const String autoLogin = 'auto';
  static const String addProblem = 'problem';
  static const String login = 'login screen';
  static const String homePage = 'sdf/';
  static const String forSale = 'for';
  static const String getOrder = 'sdf/';
  static const String onBoard = '/sfs';
  static const String notification = 'notification';
  static const String scanQrCode = 'sdfs/';
  static const String bottomNavigate = 'SFDS/';
  static const String stores = 'all stores';
}

class Routes {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.bottomNavigate:
        return MaterialPageRoute(
          builder: (context) => const BottomNav(),
        );
      case AppRoutes.addProblem:
        return MaterialPageRoute(
          builder: (context) => const AddProblemScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case AppRoutes.bottomNavAdmin:
        return MaterialPageRoute(
          builder: (context) => const BottomNavAdmin(),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );

      case AppRoutes.scanQrCode:
        return MaterialPageRoute(
          builder: (context) => QRScanPage(),
        );
      case AppRoutes.autoLogin:
        return MaterialPageRoute(
          builder: (context) => AutoLogin(),
        );
      case AppRoutes.onBoard:
        return MaterialPageRoute(
          builder: (context) => const OnBoard(),
        );

      case AppRoutes.homePage:
        return MaterialPageRoute(
          builder: (context) => HomePageItem(),
        );
      case AppRoutes.getOrder:
        return MaterialPageRoute(
          builder: (context) => OrdersScreen(
            externalId: "service",
          ),
        );

      ///OrdersScreen

      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
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
