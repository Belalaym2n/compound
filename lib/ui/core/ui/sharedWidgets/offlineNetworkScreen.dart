import 'package:flutter/material.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../utils/app_colors.dart';

class OfflineNetwork extends StatefulWidget {
  const OfflineNetwork({super.key});

  @override
  State<OfflineNetwork> createState() => _CheckNetworkState();
}

class _CheckNetworkState extends State<OfflineNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Icon(Icons.wifi_off,
                color: AppColors.primary, size: Constants.screenWidth * 0.28)),
        SizedBox(
          height: Constants.screenHeight * 0.02,
        ),
        Text(
          "No Internt Connection ",
          style: TextStyle(
            fontSize: Constants.screenWidth * 0.04,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: Constants.screenHeight * 0.01,
        ),
        Text(
          "No Internt Connection found check your \n            connection and try again",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Constants.screenWidth * 0.03),
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {},
        ),
      ],
    ));
  }
}
