import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_images.dart';

import '../../utils/app_colors.dart';

class NotificationScreen extends StatefulWidget {
final String ? tittle;
  final String ? description;
   final String  imageUrl;
 //
 //
    NotificationScreen({super.key,
   required this.tittle,
     this.imageUrl='',
    required this.description,
   });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}
double screenHeight=0;
double screenWidth=0;
class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    screenWidth=MediaQuery.of(context).size.width;
  screenHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

              Image.network(widget.imageUrl,width: screenWidth,
                  height: screenHeight*0.4,
                  fit: BoxFit.fitWidth, errorBuilder: (context, error, stackTrace) {
                  print(error);
                  // Display a placeholder image if the network image fails to load
                  return Icon(Icons.error, size: 50,color: Colors.white,);
                },),

            Text(widget.tittle!,style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.w800,
            fontSize: screenWidth*0.05),),
            Text(widget.description!,style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.w500,
                fontSize: screenWidth*0.03)),



            // Show image if URL is provided
            SizedBox(height: 8),
          ]))
    );
  }
}
