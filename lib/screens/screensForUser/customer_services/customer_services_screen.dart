import 'package:flutter/material.dart';
import 'package:qr_code/models/service_model.dart';
import 'package:qr_code/screens/screensForUser/customer_services/store.dart';
import 'package:qr_code/screens/screensForUser/request_order/request_order_screen.dart';
import 'package:qr_code/utils/app_images.dart';

import '../../../models/stores_name.dart';
import '../../../utils/app_colors.dart';

class CustomerServicesScreen extends StatefulWidget {
  CustomerServicesScreen({super.key});

  @override
  State<CustomerServicesScreen> createState() => _CustomerServicesScreenState();
}

class _CustomerServicesScreenState extends State<CustomerServicesScreen> {
  double screenHeight = 0;

  double screenWidth = 0;

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                StoreScreen(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  sources: StoresName.names,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget welcome() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: screenHeight * 0.06, //,
              width: screenWidth * 0.13,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth * 0.08,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Good Morning",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.03,
                          color: AppColors.lightBlack),
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Icon(
                      size: screenWidth * 0.05,
                      Icons.light_mode_sharp,
                      color: Colors.amber,
                    )
                  ],
                ),
                Text(
                  "Belal Ayman",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04),
                ),
              ],
            )
          ],
        ));
  }

  Widget service_text({
    required String text,
  }) {
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
          Text(
            "See All",
            style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: screenWidth * 0.04),
          ),
        ],
      ),
    );
  }

  all_stores() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Stores",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.05),
          ),
          Text(
            "See All",
            style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: screenWidth * 0.04),
          ),
        ],
      ),
    );
  }

  Padding image_offer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.07),
          child: Image.asset(
            AppImages.offer,
            fit: BoxFit.fill,
            width: screenWidth,
            height: screenHeight * 0.2,
          ),
        ),
      ),
    );
  }

  Widget showServices() => SizedBox(
        height: screenHeight * 0.25,
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              //  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04 ),
              itemCount: ServicesModel.services.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (screenWidth / 2.35) / (screenHeight * 0.17),
                crossAxisCount: 4,
                crossAxisSpacing: screenWidth * 0.03,
                mainAxisSpacing: screenWidth * 0.02,
                mainAxisExtent: screenHeight * 0.1,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index; // Update selected index
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestOrderScreen(
                            serviceName: ServicesModel.services[index].title,
                          ),
                        ));
                  },
                  child: serviceItem(
                    colorContainer: ServicesModel.services[index].color,
                    colorIcon: ServicesModel.serviceColors[index],
                    tittle: ServicesModel.services[index].title,
                    icon: ServicesModel.services[index].icon,
                    isSelected: selectedIndex ==
                        index, // Check if this item is selected
                  ),
                );
              },
            ),
          ),
        ),
      );

  Widget serviceItem({
    required String tittle,
    required IconData icon,
    required bool isSelected,
    required Color colorContainer,
    required Color colorIcon,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: screenHeight * 0.14,
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.08,
              width: screenWidth * 0.13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : colorContainer,
                border: Border.all(color: Colors.black54),
                //  borderRadius: BorderRadius.circular(screenWidth * 0.03)),
              ),
              child: Icon(
                icon,
                size: screenWidth * 0.09,
                color: isSelected ? Colors.white : colorIcon,
              ),
            ),
            Text(
              tittle,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.025,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
