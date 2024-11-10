import 'package:flutter/material.dart';
import 'package:qr_code/models/owner_login.dart';
import 'package:qr_code/utils/app_colors.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  double screenHeight = 0;

  double screenWidth = 0;

  int _selectedIndex = -1;

  String? name;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    OwnerDetails ownerDetails = OwnerDetails();
    String? retrievedName = await ownerDetails.getUserName();
    setState(() {
      name = retrievedName;
    });
  }

  // Track the selected index

  void _changeBackgroundColor(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        color: Colors.white,
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.024,
              ),
              user_data(),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              drawerWidget(
                  isSelected: _selectedIndex == 0,
                  onIconTap: () => _changeBackgroundColor(0),
                  text: "Support",
                  icon: Icons.call),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              drawerWidget(
                  isSelected: _selectedIndex == 1,
                  onIconTap: () => _changeBackgroundColor(1),
                  text: "Address",
                  icon: Icons.location_on),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              drawerWidget(
                  isSelected: _selectedIndex == 2,
                  onIconTap: () => _changeBackgroundColor(2),
                  text: "Logout",
                  icon: Icons.logout),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              drawerWidget(
                  isSelected: _selectedIndex == 3,
                  onIconTap: () => _changeBackgroundColor(3),
                  text: "Delete Account",
                  icon: Icons.logout),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerWidget(
      {required String text,
      required IconData icon,
      required bool isSelected,
      required VoidCallback onIconTap}) {
    return GestureDetector(
      onTap: onIconTap,
      child: Container(
        height: screenHeight * 0.06,
        width: screenWidth * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            color: isSelected ? AppColors.primary : Colors.white
            // border: Border.all(color: Colors.black)

            ),
        child: Row(
          children: [
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Icon(
              color: isSelected ? Colors.white : Color(0xFF535763),
              icon,
              size: screenWidth * 0.06,
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Text(
              text,
              style: TextStyle(
                  color: isSelected ? Colors.white : Color(0xFF535763),
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }

  Widget user_data() {
    return Row(
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
          width: screenHeight * 0.014,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w800, fontSize: screenWidth * 0.05),
            ),
            Text(
              "bel@gmail.com",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: screenWidth * 0.04),
            ),
          ],
        )
      ],
    );
  }
}
