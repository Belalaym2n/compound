import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/models/userModel.dart';
import 'package:qr_code/screens/admin_panel/uploadForFirebaseDatabse.dart';

import '../../utils/app_colors.dart';
import '../../utils/widgets.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}
double screenHeight = 0;
double screenWidth = 0;

class _AddUsersState extends State<AddUsers> {
  TextEditingController idController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController ownerName=TextEditingController();
  TextEditingController phoneNumberController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Add User ",style: TextStyle(
                fontSize: screenWidth*0.06,fontWeight: FontWeight.w800
              ),)),
              SizedBox(
                height: screenHeight*0.03,
              ),
              customTitle("Owner name ",screenWidth),
              SizedBox(
                height: screenHeight / 70,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: customFormField(
                    hintText: "Set Owner Name",
                    iconData: Icons.person,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    controller: ownerName,
                    obscureText: false),
              ),
              SizedBox(
                height: screenHeight*0.03,
              ),
              customTitle("Owner ID",screenWidth),
              SizedBox(
                height: screenHeight / 70,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: customFormField(
                    hintText: "Create ID",
                    iconData: Icons.person,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    controller: idController,
                    obscureText: false),
              ),
              SizedBox(
                height: screenHeight*0.03,
              ),
              customTitle("Owner Password",screenWidth),
              SizedBox(
                height: screenHeight *0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: customFormField(
                    hintText: "create password",
                    iconData: Icons.person,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    controller: passwordController,
                    obscureText: false),
              ),
              SizedBox(
                height: screenHeight *0.03,
              ),
              customTitle("Owner Address",screenWidth),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: customFormField(
                    hintText: "Set owner address",
                    iconData: Icons.person,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    controller: addressController,
                    obscureText: false),
              ),
              SizedBox(
                height: screenHeight *0.03,
              ),
              customTitle("Owner Phone",screenWidth),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: customFormField(
                    hintText: "Set owner phone",
                    iconData: Icons.person,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    controller: phoneNumberController,
                    obscureText: false),
              ),
              SizedBox(
                height: screenHeight*0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth, screenHeight / 15),
                      backgroundColor: AppColors.primary,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () async {

                      uploadData();

                    },
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth / 15,
                        fontFamily: 'Nexa Bold 650',
                      ),
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }

  uploadData()async{
    if(
    idController.text.isNotEmpty&&
    passwordController.text.isNotEmpty&&
    phoneNumberController.text.isNotEmpty&&
    addressController.text.isNotEmpty
    ){
      try{
        UserMode userMode=UserMode(password: passwordController.text,
         address: addressController.text,
         phoneNumber: phoneNumberController.text,
         id:idController.text);
      await UploadToDatabase.uploadToCollection(nameUser: ownerName.text,

          collectionName: "Owners", data: userMode.toJson());
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         backgroundColor: Colors.orangeAccent,
         content: Text(
           "User has been added Successfully",
           style: TextStyle(fontSize: 18.0),
         )));
     ownerName.clear();
     passwordController.clear();
     idController.clear();
     phoneNumberController.clear();
     addressController.clear();



    }
    catch(e){
    return showDialog(context: context, builder: (context) =>AlertDialog(
      title:Text('Error') ,
      content: Text("one of data has been empty"),
    ),);
    }}
  }


}
