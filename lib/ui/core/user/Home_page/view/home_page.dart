import 'package:flutter/material.dart';

import '../../../../../data/services/shared_pref_helper.dart';
import '../view_model/viewModeLHome.dart';
import '../widgets/home_page_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);

  ViewModelHome viewModelHome = ViewModelHome();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferencesHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HomePageItem(),
    );
  }
}
