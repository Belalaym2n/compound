import 'package:flutter/cupertino.dart';
import 'package:qr_code/utils/base.dart';

abstract class BestControllerConnector extends BaseConnector {
  step_one_content();

  step_two_content();

  final_step_content();

  Text tittleName(String tittle);

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
