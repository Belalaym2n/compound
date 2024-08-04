
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/models/user.dart';
import 'package:qr_code/screens/admin_panel/uploadForFirebaseDatabse.dart'; // For PlatformException

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  bool _hasScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      body: Center(
        child: ElevatedButton(
          onPressed: _scanQRCode,
          child: Text('Scan QR Code'),
        ),
      ),
    );
  }

  Future<void> _scanQRCode() async {
    // Prevent multiple scans


    try {
    QuerySnapshot visitors=await FirebaseFirestore.instance
        .collection("Visitors").where("dataScanned").get();

      final result = await BarcodeScanner.scan();
    bool hasBeenScannedBefore = visitors.docs
        .any((doc)
    => doc['dataScanned']
        .toString() == result.rawContent.toString());

    if(hasBeenScannedBefore){
      return  _showError('QR code has been scanned before');

      }
        if (result.rawContent.isNotEmpty) {
          _handleScan(result.rawContent.toString());
          DataScanned dataScanned=DataScanned(result.rawContent.toString());


      UploadToDatabase.uploadToCollection(collectionName: "Visitors", nameUser:
      DateTime.now().toString(), data: dataScanned.toJson());
        }} on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        _showError('Camera permission was denied');
      } else {
        _showError('Unknown error: ${e.message}');
      }
    } on FormatException {
      _showError('Scan was canceled');
    } catch (e) {
      _showError('Unknown error: $e');
    }
  }

  void _handleScan(String qrCode) async {
    // Store data in database


    // Show confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('QR Code Scanned'),
        content: Text(qrCode),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
             // Go back to the previous screen
            },
          ),
        ],
      ),
    );
  }


  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
