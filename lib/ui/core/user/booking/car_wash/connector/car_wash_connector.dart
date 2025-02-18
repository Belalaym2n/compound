import 'package:flutter/cupertino.dart';

import '../../../../../../utils/base.dart';

abstract class CarWashConnector extends BaseConnector {
  step_one_content();

  step_two_content();

  step_three_content();

  success_widget();

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
