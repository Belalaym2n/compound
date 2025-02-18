import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/elevated_button.dart';
import 'package:qr_code/ui/core/user/generateQRCode/view_model/viewModelQRCodeGenerate.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';
import 'package:qr_code/utils/base.dart';
import 'package:qr_code/utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class GeneratQrCode extends StatefulWidget {
  const GeneratQrCode({super.key});

  @override
  State<GeneratQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends BaseView<GenerateQRViewModel, GeneratQrCode> {
  TextEditingController controllerName = TextEditingController();

  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: Constants.screenWidth * 0.04,
          ),
        ),
        elevation: 0,
      ),
      body: ChangeNotifierProvider(
        create: (context) => GenerateQRViewModel(),
        builder: (context, child) => Consumer<GenerateQRViewModel>(
          builder: (context, viewModel, child) => SingleChildScrollView(
            child: Column(
              children: [
                if (viewModel.qr_data != '')
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Constants.screenHeight * 0.1,
                        ),
                        Screenshot(
                          controller: _screenshotController,
                          child: QrImageView(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            data:
                                "${controllerName.text}   date time:${DateTime.now()}",
                            size: Constants.screenWidth * 0.79,
                          ),
                        ),
                        SizedBox(
                          height: Constants.screenHeight * 0.04,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.screenWidth * 0.1),
                          child: elevated_button(
                              onPressed: () {
                                controllerName.clear();
                                viewModel.change_qr_data('');
                              },
                              buttonName: "Regenerate QR Code"),
                        ),
                        SizedBox(
                          height: Constants.screenHeight * 0.04,
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
                if (viewModel.qr_data == '')
                  create_qr_code(create_qr: () {
                    viewModel.change_qr_data(controllerName.text);
                  })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget create_qr_code({required Function create_qr}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: Constants.screenHeight * 0.04,
          ),
          image(),
          SizedBox(
            height: Constants.screenHeight * 0.06,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // Adjust padding dynamically based on keyboard height
                  ),
                  child: customFormField(
                      hintText: 'Enter full name visitor',
                      controller: controllerName,
                      iconData: Icons.person,
                      obscureText: false),
                ),
                SizedBox(
                  height: Constants.screenHeight * 0.02,
                ),
                elevated_button(
                    onPressed: () {
                      create_qr();
                    },
                    buttonName: "Create QR code")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Image image() {
    return Image.asset(
      AppImages.qr,
      width: Constants.screenWidth,
      height: Constants.screenHeight * 0.4,
    );
  }

  Widget customFormField(
      {required String hintText,
      required IconData iconData,
      required TextEditingController controller,
      required bool obscureText}) {
    return Container(
      width: Constants.screenWidth,
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
            width: Constants.screenWidth / 6,
            child: Icon(
              size: Constants.screenWidth * 0.07,
              iconData,
              color: AppColors.primary,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: Constants.screenWidth / 12),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Constants.screenHeight / 35,
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

  @override
  GenerateQRViewModel init_my_view_model() {
    // TODO: implement init_my_view_model
    return GenerateQRViewModel();
  }

  @override
  onError(String message) {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    throw UnimplementedError();
  }
}
