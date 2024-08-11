import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/models/userModel.dart';
import 'package:qr_code/screens/admin_panel/add_user/viewModel_addUser.dart';
import 'package:qr_code/screens/admin_panel/uploadForFirebaseDatabse.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/widgets.dart';

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
    ViewmodelAdduser viewmodel=ViewmodelAdduser();
    return  ChangeNotifierProvider(

      create: (BuildContext context) =>viewmodel,
      builder: (context, child) =>
       Scaffold(
        appBar: AppBar(

          flexibleSpace: Column(
            children: [
              SizedBox(
                height: screenHeight*0.05,
              ),
              Center(child: Text("Add User ",style: TextStyle(
                  fontSize: screenWidth*0.06,fontWeight: FontWeight.w800
              ),)),
            ],
          ),
          backgroundColor: Colors.white,
          bottomOpacity: 0,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: screenHeight*0.01,
                ),
                customTitle("Owner name ",screenWidth),

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
                  height: screenHeight*0.02,
                ),
                customTitle("Owner ID",screenWidth),

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
                  height: screenHeight*0.02,
                ),
                customTitle("Owner Password",screenWidth),

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
                  height: screenHeight *0.02,
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
                  height: screenHeight *0.02,
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
                  height: screenHeight*0.02,
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

                        viewmodel.uploadData(idController: idController, passwordController: passwordController, phoneNumberController: phoneNumberController, addressController: addressController, ownerName: ownerName, context: context);

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
      ),
    );
  }




}
