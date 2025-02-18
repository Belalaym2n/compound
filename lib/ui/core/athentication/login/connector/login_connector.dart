import 'package:qr_code/utils/base.dart';

abstract class LoginConnector extends BaseConnector {
  navigateAdmin();

  navigateUser();

  successWidget();

  navigateSecurity();

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
// TODO Implement this library.
