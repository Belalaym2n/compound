import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/admin_panel/getAllUsers/getAllUsersViewModel.dart';
import 'package:qr_code/screens/chat/chat_screen.dart';

import '../../../utils/app_images.dart';
import '../../../utils/widgets.dart';

class AllUsersSentMessage extends StatefulWidget {
  const AllUsersSentMessage({super.key});

  @override
  State<AllUsersSentMessage> createState() => _AllUsersSentMessageState();
}

double screenHeight = 0;
double screenWidth = 0;

class _AllUsersSentMessageState extends State<AllUsersSentMessage> {
  GetAllUserViewModel viewModel = GetAllUserViewModel();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        toolbarHeight: screenHeight * 0.09,
       flexibleSpace: Center(
         child: search(),
       ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Container(
              height: screenHeight * 0.4,
              width: screenWidth,
              child: Column(
                children: [


                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: viewModel.getMessage(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData) {
                              return Center(child: Text('No messages yet.'));
                            }

                            final messages = snapshot.data!.docs
                                .map((doc) => doc['name'])
                                .toList();

                            return ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return UsersMessages(
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    userid: messages[index].toString(),
                                    function: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatScreen(
                                                  id: messages[index],
                                                  senderId: 'admin',
                                                ),
                                          ));
                                    });
                              },
                            );
                          }))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  UsersMessages({required double screenWidth,
    required Function function,
    required double screenHeight, required String userid}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
         horizontal: 18,
        vertical: 6
      ),
      child: InkWell(
        onTap: () {
          function();
        },
        child: Container(

          width: screenWidth,
          height: screenHeight * 0.1,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              color: Color(0xFFF1F1F1)),
          child: Row(
            children: [
SizedBox(
  width: screenWidth*0.02,
),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    AppImages.userImage,
                    height: screenHeight * 0.08,

                    width: screenWidth * 0.15,
                    fit: BoxFit.fill,

                    //dcolor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "$userid",
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "last message",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                width: screenWidth * 0.3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Center(
                    child: Text(
                      "12:00 PM",
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w800),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  search() {
    return Column(

      children: [
        SizedBox(
          height: screenHeight*0.05,
        ),

        Row(

          children: [
            SizedBox(
              width: screenWidth*0.07,
            ),
            Center(
              child: Container(

                  width: screenWidth*0.8,
                  height: screenHeight * 0.05,
                  child: Expanded(
                    child: TextFormField(
                      controller: controller,

                      decoration: InputDecoration(
             prefixIcon: Icon(Icons.search),
                          //filled: true,
                          //fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight / 60,
                          ),
                          border: InputBorder.none,
                          hintText: "Search For User",

                          hintTextDirection: TextDirection.ltr,
                          hintStyle: TextStyle(

                            color: Colors.black,
                          )),


                      //   maxLines: 1,
                      obscureText: false,
                    ),
                  )
              ),
            ),
            Image.asset(AppImages.logoImage,width: screenWidth*0.1,
            color: Colors.black,
              fit: BoxFit.cover,
              height: screenHeight*0.07,
            )
          ],
        ),
      ],
    );
  }

}
