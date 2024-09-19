import 'package:flutter/material.dart';
import 'package:qr_code/screens/screens_for_admin/widget.dart';
import 'package:qr_code/utils/app_images.dart';

import '../../utils/routes.dart';
import '../screensForUser/notification_screen/getAllNotifcation.dart';
import 'getAllUsers/allUsersMessage.dart';
import 'home_for_advs.dart';

class AdminServices extends StatefulWidget {
  const AdminServices({super.key});

  @override
  State<AdminServices> createState() => _AdminServicesState();
}

class _AdminServicesState extends State<AdminServices>
    with SingleTickerProviderStateMixin {
  double screenHeight = 0;

  double screenWidth = 0;

  final bool _showContainers = false;

  late AnimationController _controller;

  final int _itemCount = 6;

//late List widgets;
  late List<Widget> widgets;

  @override
  void initState() {
    widgets = [
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
    ];
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          screenHeight = MediaQuery.of(context).size.height;
          screenWidth = MediaQuery.of(context).size.width;
          widgets = [
            itemWidger(
                image: AppImages.addUser,
                functionNavigate: () {
                  Navigator.of(context).pushNamed(AppRoutes.addUser);
                },
                screenHeight: screenHeight * 0.1,
                text: 'Add User',
                screenWidth: screenWidth),
            itemWidger(
                image: AppImages.addUser,
                functionNavigate: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AllUsersSentMessage(),
                  ));
                },
                screenHeight: screenHeight * 0.1,
                text: 'Chat with owners',
                screenWidth: screenWidth),
            itemWidger(
                image: AppImages.addUser,
                functionNavigate: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GetAllNotifications()));
                },
                screenHeight: screenHeight * 0.1,
                text: 'All Notifications',
                screenWidth: screenWidth),
            itemWidger(
                image: AppImages.addUser,
                functionNavigate: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeForAdvs(),
                      ));
                },
                screenHeight: screenHeight * 0.1,
                text: 'For Sale',
                screenWidth: screenWidth),
            itemWidger(
                image: AppImages.addUser,
                functionNavigate: () {
                  Navigator.of(context).pushNamed(AppRoutes.scanQrCode);
                },
                screenHeight: screenHeight * 0.1,
                text: 'Scan QR Code',
                screenWidth: screenWidth),
            itemWidger(
                image: AppImages.addUser,
                functionNavigate: () {
                  Navigator.of(context).pushNamed(AppRoutes.generateQr);
                },
                screenHeight: screenHeight * 0.1,
                text: 'Generate QR Code',
                screenWidth: screenWidth)
          ];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Column(children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          const Text(
            'Welcome admin',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _itemCount,
                itemBuilder: (context, index) {
                  return FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                              index / _itemCount, (index + 1) / _itemCount),
                        ),
                      ),
                      child: widgets[index]);
                }),
          )
        ]));
  }
}
