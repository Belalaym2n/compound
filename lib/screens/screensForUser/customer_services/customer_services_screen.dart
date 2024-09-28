import 'package:flutter/material.dart';
import 'package:qr_code/models/service_model.dart';
import 'package:qr_code/screens/screensForUser/request_order/request_order_screen.dart';
import 'package:qr_code/utils/app_colors.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All Services",
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.06),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [showServices()],
        ),
      ),
    );
  }

  Widget showServices() => Expanded(
        child: GridView.builder(
          //  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04 ),
          itemCount: ServicesModel.services.length,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (screenWidth / 2.35) / (screenHeight * 0.17),
              crossAxisCount: 3,
              mainAxisSpacing: screenHeight * 0.03,
              crossAxisSpacing: screenWidth * 0.03),
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
                tittle: ServicesModel.services[index].title,
                icon: ServicesModel.services[index].icon,
                isSelected:
                    selectedIndex == index, // Check if this item is selected
              ),
            );
          },
        ),
      );

  Widget serviceItem({
    required String tittle,
    required IconData icon,
    required bool isSelected,
  }) {
    return Material(
      elevation: 5,
      child: Container(
          width: screenWidth * 0.2,
          height: screenHeight * 0.1,
          decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
              border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
                size: screenWidth * 0.15,
              ),
              Text(
                tittle,
                style: TextStyle(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              )
            ],
          )),
    );
  }
}
