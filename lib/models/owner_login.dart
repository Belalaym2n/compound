import 'package:shared_preferences/shared_preferences.dart';

class OwnerDetails {
  Future<String?> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("name");
  }
}
