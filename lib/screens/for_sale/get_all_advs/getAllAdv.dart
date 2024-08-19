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
                child:GridView.builder(
                  itemCount: Advs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (192 / 220),
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2
                  ),
                  itemBuilder: (context, index) {

                final advs = Advs[index];

                return products(tittle:advs['tittle'].toString(),
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
  products({
  required String tittle,
  required String imageUrl,
  required String description,
  })=>Container(

    margin: EdgeInsets.only(left: 12, top: 16,right: 12),
    //height: screenHeight*0.2,

    child:
           Material(
             elevation: 20,
             borderRadius: BorderRadius.circular(12),
             child: Container(
              decoration: BoxDecoration(
                 // border: Border.all(color: AppColors.primary,width: 2),
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Container(

                    width: screenWidth*0.45,
                    height: screenHeight*0.18,


                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(

                      image: DecorationImage(

                        image: NetworkImage(imageUrl),

                        fit: BoxFit.fill,

                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child:  Text(tittle,style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: screenWidth*0.03
                    ),),
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth*0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child:  Text(

                              description.length<10?
                              "$description":"${description.substring(0,10)}",style: TextStyle(
                              fontWeight: FontWeight.w600,fontSize: screenWidth*0.03
                          ),),
                        ),
                      ),


                      Icon(Icons.ads_click)
                    ],
                  )
                ],
              ),
                       ),
           ));


}
