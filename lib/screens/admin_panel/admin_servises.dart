import 'package:flutter/material.dart';
import 'package:qr_code/screens/admin_panel/add_users.dart';
import 'package:qr_code/screens/admin_panel/widget.dart';
import 'package:qr_code/screens/chat/chat_screen.dart';

import '../../utils/routes.dart';
import 'getAllUsers/allUsersMessage.dart';

class AdminServices extends StatelessWidget {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight*0.01,
          ),
          const Text('Welcome admin',style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 23
          ),),
          itemWidger(

            functionNavigate: (){

              Navigator.of(context).pushNamed(AppRoutes.addUser);
            },
            screenHeight: screenHeight,
            text: 'Add User',
            screenWidth: screenWidth
          ),
          itemWidger(

              functionNavigate: (){

                Navigator.of(context).push(MaterialPageRoute(builder:
                    (context) => AllUsersSentMessage(),));
              },
              screenHeight: screenHeight,
              text: 'Chat with owners',
              screenWidth: screenWidth
          ),


        ],
      ),
      
    );
  }
}
