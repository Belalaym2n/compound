import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code/ui/core/order_detailed/widgets/widgets.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

class SuccessOrderDetailed extends StatefulWidget {
  const SuccessOrderDetailed({super.key});

  @override
  State<SuccessOrderDetailed> createState() => _SuccessOrderDetailedState();
}

class _SuccessOrderDetailedState extends State<SuccessOrderDetailed>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: Constants.screenHeight * 0.1,
              ),
              Center(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: LottieBuilder.asset(
                    "assets/json_animation/success_order_detailed.json",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                ),
              ),
              Center(
                  child: Text(
                "Order Success",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: Constants.screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              )),
              const SizedBox(height: 20),
              SlideTransition(
                position: _slideAnimation,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اترك تعليقك على الخدمة:',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'اكتب تعليقك هنا...',
                          hintStyle:
                              TextStyle(color: AppColors.subTitleTextColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        maxLines: 4,
                        style: const TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Constants.screenHeight * 0.02,
              ),
              button(onTap: () {}, buttonName: "submit")
            ],
          ),
        ),
      ),
    );
  }
}
