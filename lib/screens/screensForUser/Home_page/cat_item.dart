import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class CatItem extends StatelessWidget {
  CatItem({
    super.key,
    required this.tittle,
    required this.icon,
    required this.isSelected,
    required this.screenHeight,
    required this.screenWidth,
    required this.colorBackground,
    required this.colorIcon,
  });

  String tittle;
  double screenWidth;
  double screenHeight;
  IconData icon;
  bool isSelected;
  Color colorBackground;
  Color colorIcon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: screenHeight * 0.1,
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.08,
              width: screenWidth * 0.13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : colorBackground,
                border: Border.all(color: Colors.black54),
                //  borderRadius: BorderRadius.circular(screenWidth * 0.03)),
              ),
              child: Icon(icon, size: screenWidth * 0.09, color: Colors.white),
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
