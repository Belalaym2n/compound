import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/screens_for_security/scanQrCode/connector.dart';
import 'package:qr_code/screens/screens_for_security/scanQrCode/viewModelScan.dart';

import '../../../utils/app_colors.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> implements ScanConnector {
  String? resultScanning;
  ViewmodelScan viewmodelScan = ViewmodelScan();
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => ViewmodelScan()..scanConnector = this,
      child: Consumer<ViewmodelScan>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(centerTitle: true, title: app_bar_text()),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.8, screenHeight / 15),
                    backgroundColor: AppColors.primary,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    viewModel.operationForQRCod(context);
                  },
                  child: Text(
                    "Scan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth / 15,
                      fontFamily: 'Nexa Bold 650',
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  handleScan(String qrCode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR Code Scanned'),
        content: Text(qrCode),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              // Go back to the previous screen
            },
          ),
        ],
      ),
    );
  }

  @override
  showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Text app_bar_text() => Text(
        'QR Code Scanner',
        style: TextStyle(
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.bold,
        ),
      );
}
