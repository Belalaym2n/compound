import 'package:flutter/material.dart';

import '../../ui/core/generateQRCode/creatQrCode.dart';
import '../../ui/core/request_order/widgets/request_order_screen.dart';

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
          iconData: Icons.format_paint,
          text: 'Painting',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestOrderScreen(
                    serviceName: 'service',
                  ),
                ));
          }),
      ShowCatModel(
          colorBackground: Colors.deepPurple,
          iconData: Icons.format_paint,
          text: 'home',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestOrderScreen(
                    serviceName: 'service',
                  ),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFF00BFf6),
          iconData: Icons.format_paint,
          text: 'Steal',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestOrderScreen(
                    serviceName: 'service',
                  ),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFFFFAE35),
          iconData: Icons.electrical_services,
          text: 'electrical',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestOrderScreen(
                    serviceName: 'service',
                  ),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFFFF2424),
          iconData: Icons.qr_code_2,
          text: 'QR',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GeneratQrCode(),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFF316F5C),
          iconData: Icons.car_repair_outlined,
          text: 'repair',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestOrderScreen(
                    serviceName: 'service',
                  ),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFF00DFA6),
          iconData: Icons.format_paint,
          text: 'Room',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestOrderScreen(
                    serviceName: 'service',
                  ),
                ));
          }),
      ShowCatModel(
          colorBackground: Color(0xFFCF77F9),
          iconData: Icons.cleaning_services,
          text: 'Cleaning',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestOrderScreen(
                    serviceName: 'service',
                  ),
                ));
          }),
    ];
    return data;
  }
}
