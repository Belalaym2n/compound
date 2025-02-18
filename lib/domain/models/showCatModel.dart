import 'package:flutter/material.dart';

import '../../ui/core/user/Orders/best_controller/view/best_controller_screen.dart';
import '../../ui/core/user/Orders/home_service_or_land_scape/view/home_service_or_land_scape.dart';
import '../../ui/core/user/Orders/laundry/view/laundry_screen.dart';
import '../../ui/core/user/booking/car_wash/view/car_screen.dart';
import '../../ui/core/user/generateQRCode/view/creatQrCode.dart';

class ShowCatModel {
  String text;

  IconData iconData;
  Color colorBackground;
  final VoidCallback function;

  ShowCatModel({
    this.iconData = Icons.add,
    required this.text,
    required this.function,
    required this.colorBackground,
  });

  static getData(BuildContext context) {
    List<ShowCatModel> data = [
      ShowCatModel(
          colorBackground: Color(0xFF00BFA6),
          iconData: Icons.qr_code_2,
          text: 'QR Code',
          function: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GeneratQrCode()));
          }),
      ShowCatModel(
          colorBackground: Colors.deepPurple,
          iconData: Icons.control_camera_sharp,
          text: 'best controller',
          function: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BestControllerItem()));
          }),
      ShowCatModel(
          colorBackground: Color(0xFF00BFf6),
          iconData: Icons.flight_land_rounded,
          text: 'laundry',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LaundryScreen(),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFFFFAE35),
          iconData: Icons.landscape,
          text: 'Land scape',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeServiceOrLandScape(
                    serviceName: 'Land Scape',
                  ),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFFFF2424),
          iconData: Icons.directions_car_sharp,
          text: 'Car Wash',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarScreen(),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFFFF2424),
          iconData: Icons.home_outlined,
          text: 'Home service',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeServiceOrLandScape(
                    serviceName: 'Home Service',
                  ),
                ));
          }),
    ];
    return data;
  }
}
