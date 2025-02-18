import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../utils/app_images.dart';
import '../../../../../utils/constants.dart';

class ShowImages extends StatefulWidget {
  const ShowImages({Key? key}) : super(key: key);

  @override
  State<ShowImages> createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.all(Radius.circular(Constants.screenWidth * 0.05)),
      child: Column(
        children: [
          showImages(),
          SizedBox(
            height: Constants.screenHeight * 0.013,
          ),
          buildDotIndicator(),
        ],
      ),
    );
  }

  showImages() => Material(
        borderRadius: BorderRadius.circular(23),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Curves.linear,
            height: Constants.screenHeight * 0.18,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              _currentIndex = index;
              setState(() {});
            },
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.5,
            scrollDirection: Axis.horizontal,
          ),
          items: imageUrls.map((imageUrl) {
            return Stack(children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(Constants.screenWidth * 0.04),
                child: Image.asset(
                  height: Constants.screenHeight * 0.18,
                  width: Constants.screenWidth * 0.89,
                  imageUrl,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Skeletonizer(
                        child: Image.asset(
                      AppImages.slide2,
                      height: Constants.screenHeight * 0.2,
                      width: Constants.screenWidth,
                    ));
                  },
                ),
              ),
            ]);
          }).toList(),
        ),
      );

  Widget buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageUrls.asMap().entries.map((entry) {
        int index = entry.key;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin:
              EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.01),
          height: Constants.screenHeight * 0.01,
          width: Constants.screenWidth * 0.024,
          decoration: BoxDecoration(
            color: _currentIndex == index ? AppColors.primary : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }).toList(),
    );
  }

  final imageUrls = [
    AppImages.slide2,
    AppImages.slide1,
    AppImages.slide3,
  ];
}
