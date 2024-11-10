import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/models/showCatModel.dart';
import 'package:qr_code/screens/screensForUser/Home_page/cat_item.dart';
import 'package:qr_code/screens/screensForUser/Home_page/viewModeLHome.dart';
import 'package:qr_code/screens/screensForUser/get_all_forRent/get_all_for_rent.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../drawer_screen/drawer_screen.dart';

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

    return ChangeNotifierProvider(
        create: (context) => viewModelHome
          ..loadUserName()
          ..name,
        builder: (context, child) => SafeArea(
              child: Consumer<ViewModelHome>(
                builder: (context, viewModel, child) => Scaffold(
                    appBar: AppBar(
                        elevation: 0,
                        centerTitle: true,
                        title: viewModel.name == null
                            ? Skeletonizer(child: welcome())
                            : welcome()),
                    drawer: Drawer(
                      width: screenWidth * 0.7,
                      child: DrawerScreen(),
                    ),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.3,
                                ),
                              ],
                            ),
                          ),
                          showImages(),
                          service_text(text: "Service", navigate: () {}),
                          showCat(ShowCatModel.getData(
                            context,
                          )),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          service_text(
                              text: "For Rent",
                              navigate: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GetAllAdv(),
                                    ));
                              }),
                          SizedBox(
                            height: 0,
                          ),
                          viewModelHome.for_rent(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Builder(
                            builder: (context) {
                              final GlobalKey<SlideActionState> _key =
                                  GlobalKey();
                              return Padding(
                                padding: EdgeInsets.all(screenWidth * 0.03),
                                child: SlideAction(
                                  outerColor: Colors.white,
                                  innerColor: AppColors.primary,
                                  borderRadius: screenWidth * 0.07,
                                  text: '     Slide to detailed ordering',
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Nexa Light 350',
                                      fontSize: screenWidth / 20),
                                  key: _key,
                                  elevation: 24,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ));
  }

  Widget service_text({required String text, required Function navigate}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04),
          ),
          InkWell(
            onTap: () {
              navigate();
            },
            child: Text(
              "See All",
              style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: screenWidth * 0.04),
            ),
          ),
        ],
      ),
    );
  }

  List<String> imageUrls = [
    AppImages.slide2,
    AppImages.slide1,
    AppImages.slide3
  ];

  showImages() => Material(
        borderRadius: BorderRadius.circular(23),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Curves.linear,
            height: screenHeight * 0.18,
            aspectRatio: 16 / 9,
            viewportFraction: 0.93,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
          ),
          items: imageUrls.map((imageUrl) {
            return Stack(children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    height: screenHeight * 0.18,
                    imageUrl,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Skeletonizer(
                          child: Image.asset(
                        AppImages.slide2,
                        height: screenHeight * 0.2,
                        width: screenWidth,
                      ));
                    },
                  ),
                ),
              ),
            ]);
          }).toList(),
        ),
      );

  showCat(List<ShowCatModel> cats) => Consumer<ViewModelHome>(
        builder: (context, viewModelHome, child) => Material(
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.06),
            child: Container(
              height: screenHeight * 0.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: screenWidth * 0.05,
                      mainAxisExtent: screenHeight * 0.09,
                      crossAxisCount: 2),
                  scrollDirection: Axis.horizontal,
                  itemCount: cats.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                        onTap: () {
                          viewModelHome.selectIndex(i);
                          cats[i].function();
                        },
                        child: CatItem(
                            colorIcon: Colors.black,
                            colorBackground: cats[i].colorBackground,
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            tittle: cats[i].text,
                            icon: cats[i].iconData,
                            isSelected: false));
                  }),
            ),
          ),
        ),
      );

  Text welcome() {
    return Text(
      textAlign: TextAlign.center,
      'Welcome ${viewModelHome.name}',
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: screenWidth * 0.05),
    );
  }
}
