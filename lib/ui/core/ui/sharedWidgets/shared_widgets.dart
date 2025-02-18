import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

Text servic_name({required String serviceName, Color? textColor}) {
  return Text(
    serviceName,
    style: TextStyle(
        color: textColor ?? Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: Constants.screenWidth * 0.05),
  );
}
