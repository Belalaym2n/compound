import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;
  static String? compoundName; // المتغير الجلوبال

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    compoundName = _preferences?.getString("compoundName");
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

  static void loadCachedPhone_and_address({
    required TextEditingController phoneController,
    required TextEditingController addressController,
    TextEditingController? areaController,
  }) async {
    final phone = await SharedPreferencesHelper.getData("phone");
    final address = await SharedPreferencesHelper.getData("address");
    final area = await SharedPreferencesHelper.getData("area");

    if (phone != null) phoneController.text = phone;
    if (address != null) addressController.text = address;
    if (area != null) areaController?.text = area;

    print("Cached Data Loaded: Phone: $phone, Address: $address");
  }

  static dynamic getData(String key) {
    return _preferences!.get(key);
  }

  static Future<bool> clearAll() async {
    return await _preferences!.clear();
  }
}
