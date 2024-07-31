import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/login/login_connector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';
import '../../utils/shared_pref.dart';
import '../Home_page/home_page.dart';

class ViewModelLogin extends ChangeNotifier {
  late LoginConnector loginConnector;

  checkUserExist(
      {required String id,
      required String password,
      required BuildContext context}) async {
    if (id.isEmpty && password.isEmpty) {
      loginConnector.errorMessage("Id and Password must be not empty", context);
    } else {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Owners")
          .where("id", isEqualTo: id)
          .get();
      QuerySnapshot admins = await FirebaseFirestore.instance
          .collection("Adming")
          .where("id", isEqualTo: id)
          .get();

      try {
        if (password == snap.docs[0]['password']) {
          getUserId(key: 'address', value: snap.docs[0]['address']);
          // await SharedPref().setUserAddres(snap.docs[0]['address']);
          if (snap.docs[0]['is admin'] == true) {
            loginConnector.naviget(context);
            checkIsAdmin(value: true, key: 'isAdmin');
          }
        else if (snap.docs[0]['is security'] == true) {
          print("secuirty");
          checkIsAdmin(value: true, key: "is security");
            loginConnector.navigateSecuirty(context);
          } else {
            print("user");
            loginConnector.navigateUser(context);
            getUserId(value: id, key: 'Id');
          }
        }
      } catch (e) {
        loginConnector.errorMessage("Password or id not correct", context);
      }
    }
  }

  getUserId({required String value, required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }

  checkIsAdmin({required bool value, required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }
}
