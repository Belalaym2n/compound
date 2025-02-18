import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/user/Home_page/widgets/reques_employee.dart';
import 'package:qr_code/ui/core/user/Home_page/widgets/show_images.dart';
import 'package:qr_code/ui/core/user/Home_page/widgets/user_detail_header.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

import '../../profile/widgets/profile_screen_item.dart';
import 'cat_item.dart';

class HomePageItem extends StatefulWidget {
  HomePageItem({
    super.key,
  });

  @override
  State<HomePageItem> createState() => _HomePageItemState();
}

class _HomePageItemState extends State<HomePageItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(child: ProfileScreenItem()),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const UserDetailHeader(),
            SizedBox(
              height: Constants.screenHeight * 0.02,
            ),
            service_text(serviceName: '#SpecialForYou'),
            SizedBox(
              height: Constants.screenHeight * 0.013,
            ),
            const ShowImages(),
            SizedBox(
              height: Constants.screenHeight * 0.013,
            ),
            cat_text(),
            const CatItem(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Constants.screenWidth * 0.04),
              child: const SlideToRequestEmployee(),
            ),
          ]),
        ),
      ),
    );
  }

  cat_text() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.04),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TweenAnimationBuilder(
          tween: Tween<Offset>(
            begin: const Offset(-1, 0), // Start off-screen (left)
            end: const Offset(0, 0), // Move to original position
          ),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
          builder: (context, offset, child) {
            return Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * offset.dx, 0),
              child: child,
            );
          },
          child: Text(
            "Category",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Constants.screenWidth * 0.047,
                color: Colors.black),
          ),
        ),
        TweenAnimationBuilder(
            tween: Tween<Offset>(
              begin: const Offset(1, 0), // Start off-screen (right)
              end: const Offset(0, 0), // Move to original position
            ),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
            builder: (context, offset, child) {
              return Transform.translate(
                offset:
                    Offset(MediaQuery.of(context).size.width * offset.dx, 0),
                child: child,
              );
            },
            child: Text(
              "see All",
              style: TextStyle(
                  fontSize: Constants.screenWidth * 0.03,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary),
            ))
      ]),
    );
  }

  Widget service_text({required String serviceName}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Animation for serviceName
          TweenAnimationBuilder(
            tween: Tween<Offset>(
              begin: const Offset(-1, 0), // Start off-screen (left)
              end: const Offset(0, 0), // Move to original position
            ),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
            builder: (context, offset, child) {
              return Transform.translate(
                offset:
                    Offset(MediaQuery.of(context).size.width * offset.dx, 0),
                child: child,
              );
            },
            child: Text(
              serviceName,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: Constants.screenWidth * 0.062,
              ),
            ),
          ),

          // Animation for see All
          TweenAnimationBuilder(
            tween: Tween<Offset>(
              begin: const Offset(1, 0), // Start off-screen (right)
              end: const Offset(0, 0), // Move to original position
            ),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
            builder: (context, offset, child) {
              return Transform.translate(
                offset:
                    Offset(MediaQuery.of(context).size.width * offset.dx, 0),
                child: child,
              );
            },
            child: Text(
              "see All",
              style: TextStyle(
                fontSize: Constants.screenWidth * 0.031,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
