import 'package:flutter/material.dart';

import '../screens/common_screen/chat/chat_screen.dart';
import '../screens/screensForUser/generateQRCode/creatQrCode.dart';
import '../screens/screensForUser/get_all_forRent/get_all_for_rent.dart';
import '../screens/screensForUser/notification_screen/getAllNotifcation.dart';
import '../utils/app_images.dart';

class ShowCatModel {
  String text;
  String image;

  final VoidCallback function;

  ShowCatModel({
    required this.image,
    required this.text,
    required this.function,
  });

  static getData(BuildContext context, {required String name}) {
    List<ShowCatModel> data = [
      ShowCatModel(
          image: AppImages.cat3,
          text: 'chat',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                      id: name.toString(), senderId: name.toString()),
                ));
          }),
      ShowCatModel(
          image: AppImages.cat2,
          text: 'Notification',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetAllNotifications(),
                ));
          }),
      ShowCatModel(
          image: AppImages.cat1,
          text: 'QR',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GeneratQrCode(),
                ));
          }),
      ShowCatModel(
          image: AppImages.cat4,
          text: 'rent',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetAllAdv(),
                ));
          }),
    ];
    return data;
  }
}
