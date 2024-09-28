// import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code/utils/shared_pref.dart';
import 'package:screenshot/screenshot.dart';

class ViewModelQrCodeGenerat extends ChangeNotifier {
  String? name;

  shareQrCode(ScreenshotController screenshotController) async {
    final imageUint8List = await screenshotController.capture();
    final uint8List = imageUint8List;

    if (imageUint8List != null) {
      // await Share.file(
      //   'QR Code',
      //   'qr_code.png',
      //   uint8List!.buffer.asUint8List(),
      //   'image/png',
      //   text: 'Check out this QR code!',
      // );
    }
  }

  getSharedName() async {
    name = await SharedPref().getUserName();
    return name;
  }

  qrTracking({required int count}) async {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    await analytics.logEvent(name: 'qr_code_used', parameters: {
      'count': count,
      'timer': DateTime.now().toString(),
    });
  }
}
