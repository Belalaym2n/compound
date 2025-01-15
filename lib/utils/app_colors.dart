import 'package:flutter/material.dart';

class AppColors {
  static Color primary = const Color(0xFF242760);
  static Color masPrimary = const Color(0xFF312885);
  static Color masSecondary = const Color(0xFF009fe3);
  static Color background = const Color(0xFFF5F5F5) // خلفية فاتحة
      ;

  static Color textPrimary = const Color(0xFF333333);

  static const Color titleTextColor = Color(0xFF504e9c);
  static const Color btnColor = Color(0xFF4786ec);
  static const Color btnBorderColor = Color.fromARGB(255, 183, 181, 252);
  static const Color subTitleTextColor = Color(0xFF9593a8);
  static const Color lightBlack = Color(0xFF535763);

  // إضافة تدرجات للألوان
  static LinearGradient gradientPrimary = const LinearGradient(
    colors: [Color(0xFF242760), Color(0xFF3C3F9F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient gradientButton = const LinearGradient(
    colors: [Color(0xFF4786ec), Color(0xFF5A9CFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
//5123456789012346
//belalscg@gmail.com 1234567
}
