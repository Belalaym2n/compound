import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/for_sale/get_all_advs/detAllViewModel.dart';

import '../../../utils/app_colors.dart';
import '../../admin_panel/add_user/add_users.dart';
import '../add/for_sale.dart';

class GetAllAdv extends StatefulWidget {
  const GetAllAdv({super.key});

  @override
  State<GetAllAdv> createState() => _GetAllAdvState();
}
double screenWidth=0;
double screenHeight=0;
class _GetAllAdvState extends State<GetAllAdv> {

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    GetAllAdvsViewModel viewModel=GetAllAdvsViewModel();
    return ChangeNotifierProvider(
      create: (context) =>viewModel ,
      builder: (context, child) => Scaffold(
        body: Column(
          children: [
            FutureBuilder(future:
            viewModel.getMessage(),
                builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading indicator
              } else if (snapshot.hasError) {
              // print(snapshot.error.toString());
              return Center(child: Text('Error: ${snapshot.error}')); // Error handling
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No Advs found')); // Empty list handling
              } else {
              final Advs = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                itemCount: Advs.length,
                itemBuilder: (context, index) {

                final advs = Advs[index];

                return notificationItem(tittle:advs['tittle'].toString(),
                description:advs['description'].toString() ,
                imageUrl:advs['image']
                );
                },
                ),
              );}
              }
            )


          ],
        ),
      ),
    );
  }

  notificationItem({
    required String tittle,
    required String imageUrl,
    required String description,
  }) {
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.primary,
            ),
            width: screenWidth,
            height: screenHeight * 0.12,
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Image.network(imageUrl, width: 50,
                  height: 50, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print(error);
                    // Display a placeholder image if the network image fails to load
                    return Icon(Icons.error, size: 50,color: AppColors.primary,);
                  },
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                  height: screenHeight * 0.02,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      "${ tittle.length>10? tittle.substring(0,10):tittle}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w700),
                    ),
                    Text('${description.length>10?description.substring(0,10):description}',
                        maxLines: 1, style: TextStyle(color: Colors.white))
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.2,
                ),
                Expanded(
                    child: Icon(
                      Icons.notification_add,
                      color: Colors.white,
                      size: screenWidth * 0.1,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
