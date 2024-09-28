import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/screens_for_ssecurity/scanQrCode/viewModelScan.dart';
import 'package:qr_code/utils/app_colors.dart';

import 'connector.dart'; // For PlatformException

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> implements ScanConnector {
  @override
  void initState() {
    
    viewmodel.scanConnector = this;
    // TODO: implement initState
    super.initState();
  }

  ViewmodelScan viewmodel = ViewmodelScan();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewmodel,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Scan QR Code',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            )),
        body: Center(
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.primary)),
            onPressed: () {
              // viewmodel.scanQRCode(context);
            },
            child: const Text(
              'Scan QR Code',
              style: TextStyle(color: Colors.white),
            ),
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
}
