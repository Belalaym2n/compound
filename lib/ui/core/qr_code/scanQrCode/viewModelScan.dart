// import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../../domain/models/user.dart';
import 'connector.dart';

class ViewmodelScan extends ChangeNotifier {
  late ScanConnector scanConnector;
  String? _resultScanning;

  get resultScanning => _resultScanning;

  scanQRCode() async {
    try {
      String result = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.QR);

      print("result scanning is $result");
      _resultScanning = result;
      notifyListeners();
    } on PlatformException {
      scanConnector.showError("not scanned");
    }
  }

  Future<void> operationForQRCod(BuildContext context) async {
    // Prevent multiple scans
    try {
      QuerySnapshot visitors = await getVictors();
      await scanQRCode();
      bool hasBeenScannedBefore = visitors.docs
          .any((doc) => doc['dataScanned'].toString() == resultScanning);

      if (hasBeenScannedBefore) {
        return scanConnector.handleScan('QR code has been scanned before');
      }
      if (resultScanning != null) {
        scanConnector.handleScan(resultScanning.toString());
        DataScanned dataScanned = DataScanned(resultScanning.toString());

        upload_to_database(dataScanned);
      }
    } on PlatformException catch (e) {
      scanConnector.showError('Unknown error: ${e.message}');
    }
  }

  Future<QuerySnapshot<Object?>> getVictors() async {
    QuerySnapshot visitors = await FirebaseFirestore.instance
        .collection("Visitors")
        .where("dataScanned")
        .get();
    return visitors;
  }

  upload_to_database(DataScanned dataScanned) {
    FirebaseFirestore.instance
        .collection("Visitors")
        .doc(DateTime.now().toString())
        .set(dataScanned.toJson());
  }
}

//be@gmail.com 1234567
