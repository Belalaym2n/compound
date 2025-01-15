import 'package:qr_code/utils/base.dart';

abstract class RegisterConnector extends BaseConnector {
  navigateToLogin();

  success();

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
