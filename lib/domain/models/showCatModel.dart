import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/request_order/car_wash/widget/car_screen.dart';

import '../../ui/core/qr_code/generateQRCode/creatQrCode.dart';
import '../../ui/core/request_order/best_controller/widget/best_controller_item.dart';
import '../../ui/core/request_order/home_service/widgets/request_order_screen.dart';
import '../../ui/core/request_order/laundry/widgets/laundry_screen.dart';

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

  List<String> texts = [
    'Sky View',
    'Golden Hour',
    'Ocean Breeze',
    'Green Escape',
  ];

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
                  builder: (context) => RequestOrderScreen(
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
                  builder: (context) => RequestOrderScreen(
                    serviceName: 'Home Service',
                  ),
                ));
          }),
    ];
    return data;
  }
}
