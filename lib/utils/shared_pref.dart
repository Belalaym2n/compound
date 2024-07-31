import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  late SharedPreferences sharedPreferences;
  Future<String?> getUserName() async {
    SharedPreferences shar=await SharedPreferences.getInstance();
    return  shar.getString("Id");
  }

  shared()async{
   return sharedPreferences=await SharedPreferences.getInstance();
  }


  setUserAddres(String value) {
    return  sharedPreferences.setString("address",value );
  }
  getAddress() {
    return  sharedPreferences.getString("address");
  }
}
