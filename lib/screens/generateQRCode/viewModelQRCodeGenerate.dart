import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code/utils/shared_pref.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModelQrCodeGenerat extends ChangeNotifier{

  String? name;
  shareQrCode( ScreenshotController _screenshotController)async{
    final imageUint8List = await _screenshotController.capture(
    );
    final uint8List = imageUint8List;

    if (imageUint8List != null) {
      // Share the image via WhatsApp
      await Share.file(
        'QR Code',
        'qr_code.png',
        uint8List!.buffer.asUint8List(),
        'image/png',
        text: 'Check out this QR code!',
      );
    }
  }

  getSharedName() async {
    name = await SharedPref().getUserName();
    return name;
  }
}