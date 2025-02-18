import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;
  static String? compoundName; // المتغير الجلوبال
  static String? email; // المتغير الجلوبال
  static String? name; // المتغير الجلوبال
  static String? phone; // المتغير الجلوبال
  static String? address; // المتغير الجلوبال

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    compoundName = _preferences?.getString("compoundName");
    email = _preferences?.getString("email");
    address = _preferences?.getString("userAddressFromFirebase");
    phone = _preferences?.getString("userPhoneFromFirebase");
    name = _preferences?.getString("name");
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await _preferences!.setString(key, value);
    } else if (value is int) {
      return await _preferences!.setInt(key, value);
    } else if (value is double) {
      return await _preferences!.setDouble(key, value);
    } else if (value is bool) {
      return await _preferences!.setBool(key, value);
    } else {
      throw Exception("Invalid value type");
    }
  }

  static void loadUserDataForOrders({
    required TextEditingController phoneController,
    TextEditingController? addressController,
    TextEditingController? areaController,
    TextEditingController? nameController,
  }) async {
    final phone = await SharedPreferencesHelper.getData("phone");
    final address = await SharedPreferencesHelper.getData("address");
    final area = await SharedPreferencesHelper.getData("area");
    final name = await SharedPreferencesHelper.getData("name");

    if (phone != null) phoneController.text = phone;
    if (address != null) addressController?.text = address;
    if (area != null) areaController?.text = area;
    if (name != null) nameController?.text = name;

    print("Cached Data Loaded: Phone: $phone, Address: $address");
  }

  static dynamic getData(String key) {
    return _preferences!.get(key);
  }

  static Future<bool> clearAll() async {
    return await _preferences!.clear();
  }
}
