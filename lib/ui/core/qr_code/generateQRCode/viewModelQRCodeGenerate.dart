// import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:qr_code/utils/base.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQRViewModel extends BaseViewModel {
  String _qr_data = '';

  String get qr_data => _qr_data;

  change_qr_data(String value) {
    _qr_data = value;
    notifyListeners();
  }

  shareQrCode(ScreenshotController _screenshotController) async {
    final imageUint8List = await _screenshotController.capture();
    final uint8List = imageUint8List;
    if (imageUint8List != null) {
      await Share.shareXFiles([
        XFile.fromData(uint8List!.buffer.asUint8List(), mimeType: "image/png")
      ]);
    }
  }
}
