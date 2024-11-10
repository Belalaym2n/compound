import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/screensForUser/generateQRCode/viewModelQRCodeGenerate.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/remote/notification_api.dart';
import '../../../utils/shared_pref.dart';

class GeneratQrCode extends StatefulWidget {
  const GeneratQrCode({super.key});

  @override
  State<GeneratQrCode> createState() => _ScanQrCodeState();
}

double screenWidth = 0;
double screenHight = 0;
int count = 0;

class _ScanQrCodeState extends State<GeneratQrCode> {
  TextEditingController controllerName = TextEditingController();
  ViewModelQrCodeGenerat viewModel = ViewModelQrCodeGenerat();
  String? id;
  String? address;

  getShareAddress() async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    address = sharedPreferences.getString("address");
    setState(() {});
    return address;
  }

  @override
  void initState() {
    controllerName.text = '';

    getSharedName();

    getShareAddress();
    // TODO: implement initState
    super.initState();
  }

  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 140,
              ),
              if (controllerName.text.isNotEmpty)
                Center(
                  child: Column(
                    children: [
                      Screenshot(
                        controller: _screenshotController,
                        child: QrImageView(
                          backgroundColor: Colors.white,
                          data:
                              "${controllerName.text}  Id is :$id  date time:${DateTime.now()}",
                          size: screenWidth * 0.6,
                        ),
                      ),
                      SizedBox(
                        height: screenHight * 0.04,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  controllerName.text = '';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(screenWidth * 0.7, screenHight / 15),
                                backgroundColor: AppColors.primary,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                              ),
                              child: const Text(
                                "Regenerate Qr Code",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ))),
                      SizedBox(
                        height: screenHight * 0.04,
                      ),
                      FloatingActionButton(
                        backgroundColor: AppColors.primary,
                        onPressed: () async {
                          // Capture the QR code widget as an image
                          viewModel.shareQrCode(_screenshotController);
                        },
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  //be@gmail.com 1234567
                ),
              if (controllerName.text.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHight * 0.13,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: customFormField(
                              hintText: 'Enter full name visitor',
                              controller: controllerName,
                              iconData: Icons.person,
                              obscureText: false),
                        ),
                        SizedBox(
                          height: screenHight * 0.02,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () async {
                                  print(count);
                                  count++;

                                  setState(() {
                                    viewModel.qrTracking(count: count);
                                  });
                                  ApiNotification apiNotification =
                                      ApiNotification();
                                  apiNotification.fetchNotifications("service");
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(screenWidth * 0.8, screenHight / 15),
                                  backgroundColor: AppColors.primary,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                child: const Text(
                                  "Create Qr Code",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ))),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customFormField(
      {required String hintText,
      required IconData iconData,
      required TextEditingController controller,
      required bool obscureText}) {
    return Container(
      width: screenWidth,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(2, 2)),
          ]),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 6,
            child: Icon(
              iconData,
              color: AppColors.primary,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hintText,
                ),
                maxLines: 1,
                obscureText: obscureText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getSharedName() async {
    id = await SharedPref().getUserName();
    setState(() {});
    return id;
  }
}
