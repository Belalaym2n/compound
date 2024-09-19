import 'package:flutter/cupertino.dart';

abstract class RentConnector {
  loading();

  show_data();

  errorMessage(String error, BuildContext context);
}
