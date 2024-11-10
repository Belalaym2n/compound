// import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code/utils/shared_pref.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ViewModelQrCodeGenerat extends ChangeNotifier {
  String? name;

  shareQrCode(ScreenshotController _screenshotController) async {
    final imageUint8List = await _screenshotController.capture();
    final uint8List = imageUint8List;
    if (imageUint8List != null) {
      await Share.shareXFiles([
        XFile.fromData(uint8List!.buffer.asUint8List(), mimeType: "image/png")
      ]);
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
