import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/models/showCatModel.dart';
import 'package:qr_code/screens/Home_page/viewModeLHome.dart';
import 'package:qr_code/screens/chat/chat_screen.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenHeight = 0;

  double screenWidth = 0;
  ViewModelHome viewModelHome = ViewModelHome();
  String? name;
  SharedPreferences? sharedPreferences;

  getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences?.getString("Id");
    });
    return name;
  }

  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    List<ShowCatModel> data = [
      ShowCatModel(image
          : AppImages.cat1, text: 'chat'),
      ShowCatModel(image
          : AppImages.cat2, text: 'Notification'),
      ShowCatModel(image
          : AppImages.cat1, text: 'QR'),
      ShowCatModel(image
          : AppImages.cat2, text: 'rent'),
    ];

    int _currentIndex = 0;
    List<String> imageUrls = [
      AppImages.slide2,
      AppImages.slide2,
      AppImages.slide2,
    ];

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Welcome ${name}',
                      style: TextStyle(
                          color: AppColors.primary,
          
                          fontWeight:
                      FontWeight.w600, fontSize: 22),
                    ),
                    Spacer(),
                    Image.asset(
                      AppImages.logoImage,
                      height: screenHeight * 0.1,
                      color: Colors.black,
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
                    height: screenHeight * 0.25,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.93,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: imageUrls.map((imageUrl) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
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
                padding: const EdgeInsets.only(
                  left: 8
                ),
                child: Text(
                  'For Rent',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w700),
                ),
              ),
              products(),


            ],
          ),
        ));
  }

  catItem(List<ShowCatModel>cats) => Material(

    child: Container(
          height: screenHeight*0.14,
          margin: EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12)
          ),
          child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisExtent: screenHeight*0.12,
                      crossAxisCount: 1),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                  Container(
                  width: screenWidth*0.23,
                  height: screenHeight*0.1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(cats[i].image??''),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${cats[i].text}",
                      style: TextStyle(
                        color: Color(0xFF06004E),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              }),
        ),
  );
  products()=>Material(
    elevation: 5,
    child: Container(

      margin: EdgeInsets.only(left: 16, top: 16),
      height: screenHeight*0.2,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 16,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 20,
              shadowColor: AppColors.primary,


              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: AppColors.primary,width: 2),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    Container(

                      width: screenWidth*0.4,
                      height: screenHeight*0.12,
                      padding: EdgeInsets.only(
                        top: 8,
                        left: 134,
                        right: 8,
                        bottom: 98,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(

                        image: DecorationImage(

                          image: AssetImage(AppImages.slide2),

                          fit: BoxFit.fill,

                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                      child: Container(
                        width: screenWidth*0.05,
                        height: screenHeight*0.015,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          size: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child:  Text("tittle",style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: screenWidth*0.03
                      ),),
                    ),
                    Row(
                      children: [
                        Container(
                          width: screenWidth*0.3,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child:  Text(" All Description",style: TextStyle(
                                fontWeight: FontWeight.w600,fontSize: screenWidth*0.03
                            ),),
                          ),
                        ),


                        Icon(Icons.ads_click),

                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    ),
  );
}
