import 'package:flutter/cupertino.dart';

abstract class RegisterConnector {
  errorMessage(String error, BuildContext context);

  navigateToLogin(BuildContext context);
}
