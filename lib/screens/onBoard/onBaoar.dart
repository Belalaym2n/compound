import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../domain/models/onBoardModel.dart';
import 'componts.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardScreen();
}

class _OnBoardScreen extends State<OnBoard> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  List<OnBoardModel> items = OnBoardModel.items;
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// Anime
  Widget animationDo(
    int index,
    int delay,
    Widget child,
  ) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: items.length,
                  onPageChanged: (newIndex) {
                    setState(() {
                      currentIndex = newIndex;
                    });
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        children: [
                          /// IMG
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                            width: size.width,
                            height: size.height / 2.5,
                            child: animationDo(
                              index,
                              100,
                              Image.asset(items[index].imageUrl),
                            ),
                          ),

                          /// TITLE TEXT
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 15),
                              child: animationDo(
                                index,
                                300,
                                Text(
                                  items[index].headline,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.076),
                                ),
                              )),

                          /// SUBTITLE TEXT
                          animationDo(
                            index,
                            500,
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  items[index].description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: screenWidth * 0.034),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              /// ---------------------------
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// PAGE INDICATOR
                    SmoothPageIndicator(
                      controller: pageController,
                      count: items.length,
                      effect: ExpandingDotsEffect(
                        spacing: 6.0,
                        radius: 10.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        expansionFactor: 3.8,
                        dotColor: Colors.grey,
                        activeDotColor: AppColors.primary,
                      ),
                      onDotClicked: (newIndex) {
                        setState(() {
                          currentIndex = newIndex;
                          pageController.animateToPage(newIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        });
                      },
                    ),
                    currentIndex == 2

                        /// GET STARTED BTN
                        ? GetStartBtn(size: size, textTheme: textTheme)

                        /// SKIP BTN
                        : SkipBtn(
                            size: size,
                            textTheme: textTheme,
                            onTap: () {
                              setState(() {
                                pageController.animateToPage(2,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastOutSlowIn);
                              });
                            },
                          )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
