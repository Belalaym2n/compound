// import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';

import 'connector.dart';

class ViewmodelScan extends ChangeNotifier {
  late ScanConnector scanConnector;
//
// Future<void> scanQRCode(BuildContext context) async {
//   // Prevent multiple scans
//   try {
//     QuerySnapshot visitors = await FirebaseFirestore.instance
//         .collection("Visitors")
//         .where("dataScanned")
//         .get();
//
//     // final result = await BarcodeScanner.scan();
//     bool hasBeenScannedBefore = visitors.docs.any((doc) =>
//         doc['dataScanned'].toString() == result.rawContent.toString());
//
//     if (hasBeenScannedBefore) {
//       return scanConnector.handleScan('QR code has been scanned before');
//     }
//     if (result.rawContent.isNotEmpty) {
//       scanConnector.handleScan(result.rawContent.toString());
//       DataScanned dataScanned = DataScanned(result.rawContent.toString());
//
//       UploadToDatabase.uploadToCollection(
//           collectionName: "Visitors",
//           nameUser: DateTime.now().toString(),
//           data: dataScanned.toJson());
//     }
//   } on PlatformException catch (e) {
//     if (e.code == BarcodeScanner.cameraAccessDenied) {
//       scanConnector.showError('Camera permission was denied');
//     } else {
//       scanConnector.showError('Unknown error: ${e.message}');
//     }
//   } on FormatException {
//     scanConnector.showError('Scan was canceled');
//   } catch (e) {
//     scanConnector.showError('Unknown error: $e');
//   }
// }
}
