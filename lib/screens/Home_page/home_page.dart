import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/models/showCatModel.dart';
import 'package:qr_code/screens/Home_page/viewModeLHome.dart';
import 'package:qr_code/screens/chat/chat_screen.dart';
import 'package:qr_code/screens/for_sale/get_all_advs/getAllAdv.dart';
import 'package:qr_code/screens/generateQRCode/creatQrCode.dart';
import 'package:qr_code/screens/notification_screen/getAllNotifcation.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';
import 'package:qr_code/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/notification_model.dart';
import '../notification_screen/notification_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  double screenHeight = 0;

  double screenWidth = 0;

  String? name;
  SharedPreferences? sharedPreferences;
  late AnimationController controller;

  getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences?.getString("Id");
    });
    return name;
  }

  late List<ShowCatModel> data;
  int _itemCount = 0;
  ViewModelHome viewModelHome = ViewModelHome();

  @override
  void initState() {
    data = [];

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..forward();
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          data = [
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
                        builder: (context) => GetAllNotifications(),
                      ));
                }),
            ShowCatModel(
                image: AppImages.cat1,
                text: 'QR',
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneratQrCode(),
                      ));
                }),
            ShowCatModel(
                image: AppImages.cat4,
                text: 'rent',
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetAllAdv(),
                      ));
                }),
          ];
          _itemCount = 4;
        });
      });
    });

    getUser();
    // TODO: implement initState
    super.initState();
  }

  int _currentIndex = 0;
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

    return ChangeNotifierProvider(
      create: (context) => viewModelHome,
      builder: (context, child) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: Column(
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
                        'Welcome ${name}',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(23),
                child: CarouselSlider(
                  options: CarouselOptions(
                    //
                    // autoPlayInterval:  Duration(
                    //   seconds: 4
                    // ),

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
                    onPageChanged: (index, reason) {
                      _currentIndex = index;
                    },
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
              ),
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
              catItem(data),
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
                              builder: (context) => GetAllAdv(),
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
              FutureBuilder(
                  future: viewModelHome.getAllAdV(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child:
                              CircularProgressIndicator()); // Loading indicator
                    } else if (snapshot.hasError) {
                      // print(snapshot.error.toString());
                      return Center(
                          child: Text(
                              'Error: ${snapshot.error}')); // Error handling
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Text('No Advs found')); // Empty list handling
                    } else {
                      final Advs = snapshot.data!.docs;
                      return Expanded(
                        child: ListView.builder(

                          scrollDirection: Axis.horizontal,
                          itemCount: Advs.length,
                          itemBuilder: (context, index) {
                            final advs = Advs[index];

                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 7),
                                child: products(
                                    tittle: advs['tittle'].toString(),
                                    description: advs['description'].toString(),
                                    imageUrl: advs['image']));
                          },
                        ),
                      );
                    }
                  }),

              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last Notifications',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Row(
                        children: [
                          Text(
                            'See ALL',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<NotificationModel>>(
                  future: NotificationService.getLastNotifications(), // Call your getNotifications function
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Loading indicator
                    } else if (snapshot.hasError) {
                      // print(snapshot.error.toString());
                      return Center(child: Text('Error: ${snapshot.error}')); // Error handling
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return
                        notificationItem(
                            tittle: "Wait Notification",
                            description: "no notification exist",
                            imageUrl: AppImages.cat2); // Empty list handling
                    } else {
                      final notifications = snapshot.data!;



                          return notificationItem(tittle:notifications[0].tittle.toString(),
                              description:notifications[0].description ,
                              imageUrl:notifications[0].image);
                                             }
                  } ),

            ],
          )),
    );
  }

  catItem(List<ShowCatModel> cats) => Material(
        child: Container(
          height: screenHeight * 0.13,
          margin: EdgeInsets.only(left: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisExtent: screenHeight * 0.12,
                  crossAxisCount: 1),
              scrollDirection: Axis.horizontal,
              itemCount: cats.length,
              itemBuilder: (context, i) {
                return FadeTransition(
                    opacity:
                        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                      parent: controller,
                      curve: Interval(i / _itemCount, (i + 1) / _itemCount),
                    )),
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
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${cats[i].text}",
                          style: TextStyle(
                            color: Color(0xFF06004E),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ));
              }),
        ),
      );

  products({
    required String tittle,
    required String imageUrl,
    required String description,
  }) =>
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationScreen(
                    tittle: tittle,
                    imageUrl: imageUrl!,
                    description: description),
              ));
        },
        child: Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 20,
          shadowColor: AppColors.primary,
          child: Container(
         //height: *0.7,

            padding: EdgeInsets.only(
              left: 14,
              right: 14,
            ),
            decoration: BoxDecoration(
                // border: Border.all(color: AppColors.primary,width: 2),
                borderRadius: BorderRadius.circular(16)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.14,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        // ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "$tittle",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.03),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            description.length < 20
                                ? "$description"
                                : "${description.substring(0, 20)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ),
                      Icon(Icons.ads_click),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  notificationItem({
    required String tittle,
    String? imageUrl,
    required String description,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationScreen(
                  tittle: tittle,
                  imageUrl: imageUrl!,
                  description: description),
            ));
      },
      child: Material(
        elevation: 30,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            elevation: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white38,
              ),
              width: screenWidth,
              height: screenHeight * 0.12,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image. network(
                        imageUrl!,
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.12,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print(error);
                          // Display a placeholder image if the network image fails to load
                          return Icon(
                            Icons.error,
                            size: 50,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.01,
                    height: screenHeight * 0.02,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Text(
                        "${tittle.length > 20 ? tittle.substring(0, 20) : tittle}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                          '${description.length > 20 ? description.substring(0, 20) : description}',
                          maxLines: 1,
                          style: TextStyle(color: Colors.black))
                    ],
                  ),
                  SizedBox(
                    width: screenWidth * 0.16 ,
                  ),
                  Expanded(
                      child: Icon(
                    Icons.notification_important,
                    color: Colors.red,
                    size: screenWidth * 0.1,
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
