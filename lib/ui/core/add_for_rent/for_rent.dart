import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/utils/widgets.dart';

import '../../../utils/app_colors.dart';
import 'forSaleViewModel.dart';

class ForSale extends StatefulWidget {
  const ForSale({super.key});

  @override
  State<ForSale> createState() => _ForSaleState();
}

double screenWidth = 0;
double screenHeight = 0;
String? image;

var tittleController = TextEditingController();
var descriptionController = TextEditingController();

class _ForSaleState extends State<ForSale> {
  ViewModelForSale viewModel = ViewModelForSale();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'For Sale',
              style: TextStyle(
                  fontSize: screenWidth * 0.06, fontWeight: FontWeight.w800),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(children: [
                viewModel.imageFile != null && image == null
                    ? Image.file(
                        viewModel.imageFile!,
                        height: screenHeight * 0.3,
                        width: screenWidth,
                        fit: BoxFit.fill,
                      )
                    : InkWell(
                        onTap: () async {
                          await viewModel.openGallery();

                          setState(() {});
                        },
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 300,
                        ),
                      ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                customFormField(
                    hintText: "Add tittle ",
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    iconData: Icons.title,
                    controller: tittleController,
                    obscureText: false),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                customFormField(
                    hintText: "Add Description ",
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    iconData: Icons.title,
                    controller: descriptionController,
                    obscureText: false),
                SizedBox(
                  height: screenHeight * 0.03,
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
                              viewModel.imageFile != null &&
                                      tittleController.text.isNotEmpty &&
                                      descriptionController.text.isNotEmpty
                                  ? viewModel.uploadToDataBase(
                                      image: viewModel.imageUrl.toString(),
                                      tittle: tittleController.text,
                                      description: descriptionController.text)
                                  : showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialog(
                                        title: Text('error'),
                                        content:
                                            Text('All data must be not empty'),
                                      ),
                                    );
                              setState(() {
                                print("object");
                                image = 'selected';
                                descriptionController.clear();
                                tittleController.clear();
                              });
                            },
                            child: Text(
                              "Upload",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth / 15,
                                fontFamily: 'Nexa Bold 650',
                              ),
                            ))))
              ]),
            ),
          )),
    );
  }
}
