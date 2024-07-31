import 'package:flutter/cupertino.dart';
import 'package:qr_code/screens/Home_page/home_page.dart';
import 'package:qr_code/screens/admin_panel/admin_servises.dart';
import 'package:qr_code/screens/login/login_screen.dart';
import 'package:qr_code/screens/scanQrCode/scanQrCode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoLogin extends StatefulWidget {


  @override
  State<AutoLogin> createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
 late SharedPreferences sharedPreferences;

  bool isLogin=false;
  bool isAdmin=false;
  bool isSecurity=false;

 checkUserLogin()async{
   sharedPreferences=await SharedPreferences.getInstance();
   if(sharedPreferences.getString("Id")!=null){
setState(() {
  isLogin=true;
});
   } if(sharedPreferences.getBool('isAdmin')==true){
     setState(() {
       isAdmin=true;
     });
   }else{
     setState(() {
       isSecurity=true;

     });
   }
 }
 @override
  void initState() {
    checkUserLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  isAdmin?AdminServices():isLogin? HomePage():isSecurity?QRScanPage(): LoginScreen();
  }



}
