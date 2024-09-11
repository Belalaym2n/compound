import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/models/showCatModel.dart';
import 'package:qr_code/screens/Home_page/viewModeLHome.dart';
import 'package:qr_code/screens/Home_page/widget_home.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/notification_model.dart';
import '../../utils/shimmer.dart';
import '../for_sale/get_all_forRent/getAllAdv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenHeight = 0;

  double screenWidth = 0;

  String? name;
  SharedPreferences? sharedPreferences;

  getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences?.getString("Id");
    });
    return name;
  }

  ViewModelHome viewModelHome = ViewModelHome();

  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

  Future<List<NotificationModel>> lastNotification =
      NotificationService.getNotifications();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

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
              height: screenHeight * 0.2,
              aspectRatio: 16 / 9,
              viewportFraction: 0.93,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {},
            ),
            items: imageUrls.map((imageUrl) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        height: screenHeight * 0.18,
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.16,
                      ),
                    ],
                  )
                ],
              );
            }).toList(),
          ),
        );

    return ChangeNotifierProvider(
      create: (context) => viewModelHome,
      builder: (context, child) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.3,
                      ),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Welcome $name',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ),
                showImages(),
                SizedBox(
                  height: screenHeight * 0.00,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'All Service',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                catItem(ShowCatModel.getData(context, name: name.toString())),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'For Rent',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GetAllAdv(),
                              ));
                        },
                        child: Text(
                          'See ALL',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.25,
                  child: FutureBuilder(
                      future: viewModelHome.getAllAdV(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4, // Number of shimmer placeholders
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 14),
                                child: shimmerEffect_advs(
                                  height: screenHeight * 0.25,
                                  width: screenWidth * 0.5,
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          // print(snapshot.error.toString());
                          return Center(
                              child: Text(
                                  'Error: ${snapshot.error}')); // Error handling
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child:
                                  Text('No ADV found')); // Empty list handling
                        } else {
                          final Advs = snapshot.data!.docs;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Advs.length,
                            itemBuilder: (context, index) {
                              final advs = Advs[index];

                              return SizedBox(
                                width: screenWidth * 0.5,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 14),
                                    child: products(
                                        tittle: advs['tittle'].toString(),
                                        description:
                                            advs['description'].toString(),
                                        imageUrl: advs['image'],
                                        context: context,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth)),
                              );
                            },
                          );
                        }
                      }),
                ),
                FutureBuilder<List<NotificationModel>>(
                    future: NotificationService.getLastNotifications(),
                    // Call your getNotifications function
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return notification_not_exist_shimmer(
                            height: screenHeight * 0.12,
                            width: screenWidth); // Loading indicator
                      } else if (snapshot.hasError) {
                        // print(snapshot.error.toString());
                        return Center(
                            child: Text(
                                'Error: ${snapshot.error}')); // Error handling
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return notification_not_exist();

                        //notification_not_exist(); // Empty list handling
                      } else {
                        final notifications = snapshot.data!;

                        return notificationItem(
                            context: context,
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            tittle: notifications[0].tittle.toString(),
                            description: notifications[0].description,
                            imageUrl: notifications[0].image);
                      }
                    }),
              ],
            ),
          )),
    );
  }

  Widget notification_not_exist() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: screenHeight * 0.12,
          width: screenWidth,
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.12,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
                child: const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notification_important,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      "Wait  for last notification",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      );

  catItem(List<ShowCatModel> cats) => Material(
        child: Container(
          height: screenHeight * 0.13,
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisExtent: screenHeight * 0.12,
                  crossAxisCount: 1),
              scrollDirection: Axis.horizontal,
              itemCount: cats.length,
              itemBuilder: (context, i) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("belal");
                          cats[i].function();
                        },
                        child: Container(
                          width: screenWidth * 0.17,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(cats[i].image ?? ''),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        cats[i].text,
                        style: const TextStyle(
                          color: Color(0xFF06004E),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
}
