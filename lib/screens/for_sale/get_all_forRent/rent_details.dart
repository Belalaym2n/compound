import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detAllViewModel.dart';

class RentDetails extends StatefulWidget {
  final String? tittle;
  final String? description;
  final String imageUrl;
  final String phoneNumber;

  //
  //
  const RentDetails({
    super.key,
    required this.tittle,
    this.imageUrl = '',
    this.phoneNumber = '',
    required this.description,
  });

  @override
  State<RentDetails> createState() => _NotificationScreenState();
}

double screenHeight = 0;
double screenWidth = 0;

class _NotificationScreenState extends State<RentDetails> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    GetAllAdvsViewModel viewModel = GetAllAdvsViewModel();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: screenHeight * 0.04,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(
                widget.imageUrl,
                width: screenWidth,
                height: screenHeight * 0.4,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ));
                },
                errorBuilder: (context, error, stackTrace) {
                  print(error);
                  // Display a placeholder image if the network image fails to load
                  return const Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.white,
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.tittle!,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.06),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(widget.description!,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.03)),
              ),

              // Show image if URL is provided
              SizedBox(height: screenHeight * 0.2),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                        fixedSize: WidgetStatePropertyAll(
                            Size(screenWidth * 0.5, screenHeight * 0.03)),
                        backgroundColor:
                            WidgetStatePropertyAll(Color(0xFF5efb7a)),
                        alignment: Alignment.bottomCenter,
                      ),
                      onPressed: () {
                        print("be;a;");
                        viewModel.openWhatsApp(
                            "+201114324251", "how can us help you");
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 0,
                          ),
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            'Contact Us',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.06),
                          ),
                        ],
                      )),
                ),
              )
            ]),
          )),
    );
  }
}
