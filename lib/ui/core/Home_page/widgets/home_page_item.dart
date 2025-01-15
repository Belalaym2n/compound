import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/Home_page/widgets/cat_item.dart';
import 'package:qr_code/ui/core/Home_page/widgets/reques_employee.dart';
import 'package:qr_code/ui/core/Home_page/widgets/show_images.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

class HomePageItem extends StatefulWidget {
  HomePageItem({
    super.key,
  });

  @override
  State<HomePageItem> createState() => _HomePageItemState();
}

class _HomePageItemState extends State<HomePageItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        build_user_details(),
        SizedBox(
          height: Constants.screenHeight * 0.02,
        ),
        service_text(serviceName: '#SpecialForYou'),
        SizedBox(
          height: Constants.screenHeight * 0.013,
        ),
        ShowImages(),
        SizedBox(
          height: Constants.screenHeight * 0.013,
        ),
        cat_text(),
        CatItem(),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.04),
          child: SlideToRequestEmployee(),
        ),
      ]),
    );
  }

  cat_text() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.04),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "Category",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        Text(
          "see All",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.primary),
        )
      ]),
    );
  }

  Widget build_user_details() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Constants.screenWidth * 0.067),
            bottomRight: Radius.circular(Constants.screenWidth * 0.067),
          )),
      height: Constants.screenHeight * 0.2,
      width: Constants.screenWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: Constants.screenHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'location',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (Constants.screenWidth * 0.032),
                          fontWeight: FontWeight.w300),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        Text(
                          "New Yourk,USA",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Constants.screenWidth * 0.036,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.white,
                          size: Constants.screenWidth * 0.075,
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle),
                  child: Icon(
                    size: Constants.screenWidth * 0.075,
                    Icons.person,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Constants.screenHeight * 0.02,
            ),
            Container(
              height: Constants.screenHeight * 0.05,
              width: Constants.screenWidth * 0.8,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Constants.screenWidth * 0.033),
                color: Color(0xFFf3f7fa),
              ),
              child: Center(
                  child: Text(
                "MAS Facility Management",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: (Constants.screenWidth * 0.036),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget service_text({required String serviceName}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            serviceName,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: Constants.screenWidth * 0.062),
          ),
          Text(
            "see All",
            style: TextStyle(
                fontSize: Constants.screenWidth * 0.031,
                fontWeight: FontWeight.w900,
                color: AppColors.primary),
          )
        ],
      ),
    );
  }
}
