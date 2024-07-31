import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/Home_page/viewModeLHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../utils/routes.dart';
import '../admin_panel/widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenHeight = 0;

  double screenWidth = 0;
 ViewModelHome viewModelHome=ViewModelHome();
 String? name;
   SharedPreferences ? sharedPreferences;
  getUser()async{
    sharedPreferences=await SharedPreferences.getInstance();
    name=sharedPreferences?.getString("Id");
    setState(() {

    });
    return name;
  }
@override
  void initState() {
   getUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    


    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body:
           Column(
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),


              Text(
                'Welcome ${name}',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23),
              ),
              itemWidger(
                  functionNavigate: () {
                    Navigator.of(context).pushNamed(AppRoutes.generateQr);
                  },
                  screenHeight: screenHeight,
                  text: 'Generate QR Code',
                  screenWidth: screenWidth)
            ],
          ));
  }

}
