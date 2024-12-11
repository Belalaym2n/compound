import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code/ui/core/order_detailed/widgets/success_order_detailed.dart';
import 'package:qr_code/utils/app_images.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../utils/app_colors.dart';

class OrderDetailedScreen extends StatefulWidget {
  @override
  _OrderDetailedScreenState createState() => _OrderDetailedScreenState();
}

class _OrderDetailedScreenState extends State<OrderDetailedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'طلب أوردر جديد',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  image(),
                  const SizedBox(height: 20),
                  order_field(),
                  const SizedBox(height: 30),
                  request_order_button(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  request_order_button() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessOrderDetailed(),
            ));
        // Functionality for submitting the order
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.019),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
        ),
      ),
      child: const Text(
        'إرسال الطلب',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  image() {
    return Image.asset(
      AppImages.order_detailed,
      width: Constants.screenWidth,
      height: Constants.screenHeight * 0.27, //
      fit: BoxFit.contain,
    );
  }

  Widget success_order() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Constants.screenHeight * 0.2,
            ),
            Center(
              child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height / 3,
                  child: LottieBuilder.asset(
                    "assets/json_animation/animation.json",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                  )),
            ),
            Text(
              "Order Success",
              style: TextStyle(
                  color: Colors.green, fontSize: Constants.screenWidth * 0.07),
            ),
          ],
        ),
      ),
    );
  }

  order_field() {
    return Material(
      borderRadius: BorderRadius.circular(Constants.screenWidth * 0.015),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(Constants.screenWidth * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.edit_note,
              color: AppColors.subTitleTextColor,
              size: Constants.screenWidth * 0.07,
            ),
            SizedBox(
              width: Constants.screenWidth * 0.03,
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'متى تريد غسل سيارتك ...؟',
                  hintStyle: TextStyle(
                    color: AppColors.subTitleTextColor,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: 5,
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontSize: Constants.screenWidth * 0.041,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
