import 'package:flutter/cupertino.dart';

abstract class RequestOrderConnector {
  first_step();

  stepTwoContent();

  step_three_content({required String price});

  final_step_content(bool isLoading);

  Text tittleName(String tittle);

  errorMessage(String error);
}
