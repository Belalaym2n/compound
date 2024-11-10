import 'package:flutter/cupertino.dart';

abstract class LoginConnector {
  errorMessage(String error, BuildContext context);

  navigateAdmin(BuildContext context);

  navigateUser(BuildContext context);

  navigateSecurity(BuildContext context);
}
// TODO Implement this library.
