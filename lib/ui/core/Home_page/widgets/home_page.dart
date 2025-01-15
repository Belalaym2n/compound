import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/Home_page/widgets/home_page_item.dart';

import '../view_model/viewModeLHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);
  double screenHeight = 0;
  double screenWidth = 0;
  int? selectedIndex;

  ViewModelHome viewModelHome = ViewModelHome();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: HomePageItem(),
    );
  }
}
