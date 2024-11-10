import 'package:flutter/cupertino.dart';

abstract class RequestOrderConnector {
  step_one_content();

  final_step_content();

  Text tittleName(String tittle);

  errorMessage(String error);
}
