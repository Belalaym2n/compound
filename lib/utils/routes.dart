import 'package:flutter/material.dart';
import 'package:qr_code/screens/bottom/bottom_navigation/bottomNavigation.dart';
import 'package:qr_code/screens/bottom/bottom_navigation_admin/bottom_nav_admin.dart';
import 'package:qr_code/ui/core/Home_page/widgets/home_page.dart';

import '../screens/onBoard/onBaoar.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../ui/core/add_for_rent/for_rent.dart';
import '../ui/core/athentication/login/auto_login/autoLogin.dart';
import '../ui/core/athentication/login/widgets/login_screen_.dart';
import '../ui/core/athentication/sign_up/widgets/register_screen.dart';
import '../ui/core/customer_services/widgets/customer_services_screen.dart';
import '../ui/core/generateQRCode/creatQrCode.dart';
import '../ui/core/orders/widgets/notifcation_service.dart';
import '../ui/core/scanQrCode/scanQrCode.dart';

class AppRoutes {
  static const String adminService = '/sda';
  static const String generateQr = 'generate';
  static const String register = 'register';
  static const String customer = 'customer';
  static const String bottomNavAdmin = 'zfds/';
  static const String splash = '/sdfsd';
  static const String autoLogin = 'auto';
  static const String login = 'login screen';
  static const String homePage = 'sdf/';
  static const String forSale = 'for';
  static const String getOrder = 'sdf/';
  static const String onBoard = '/sfs';
  static const String notification = 'notification';
  static const String scanQrCode = 'sdfs/';
  static const String bottomNavigate = '/';
  static const String stores = 'all stores';
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
      case AppRoutes.bottomNavAdmin:
        return MaterialPageRoute(
          builder: (context) => const BottomNavAdmin(),
        );

      case AppRoutes.customer:
        return MaterialPageRoute(
          builder: (context) => CustomerServicesScreen(),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      // case AppRoutes.notification:
      //       // return MaterialPageRoute(
      //       //   builder: (context) =>  NotificationScreen(tittle: '',),
      //       // );
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
          builder: (context) => const HomePage(),
        );
      case AppRoutes.getOrder:
        return MaterialPageRoute(
          builder: (context) => OrdersScreen(
            externalId: "service",
          ),
        );

      ///OrdersScreen
      case AppRoutes.forSale:
        return MaterialPageRoute(
          builder: (context) => const ForSale(),
        );
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
