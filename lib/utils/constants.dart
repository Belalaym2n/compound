import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  SharedPreferences? sharedPreferences;
  static const imageUrl = "assets/images/";
  static const String base_url = "https://accept.paymob.com/api";
  static const String auth_taken_enpoint = "/auth/tokens";
  static const String order_id_enpoint = "/ecommerce/orders";

  static const appId = 1362999457;
  static const appSign =
      'e4e456c1a7e52109c3f05361598149731f15d42fe55697425f68db7d70ae89b7';
  static String oneSignalAppId = "0eda7f4e-c25e-4438-bdb3-4aea23a39541";
  static String oneSignalApiKey =
      "NWZjMjc2YTMtYjViOC00NTI5LTgyYmEtMDE1OWVkMjAwYzk4";
  static late double screenHeight;
  static late double screenWidth;

  static void initSize(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}
