import 'package:flutter/cupertino.dart';

abstract class LoginConnector {

  errorMessage(String error, BuildContext context);

  naviget(BuildContext context);

  navigateUser(BuildContext context);

  navigateSecuirty(BuildContext context);
}
