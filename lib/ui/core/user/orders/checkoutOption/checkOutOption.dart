import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../utils/app_colors.dart';
import '../../online_payment/view/payment_screen.dart';

class CheckOutOption extends StatelessWidget {
  CheckOutOption({
    super.key,
    required this.sumbmitToDataBase,
    required this.price,
    required this.isLoading,
  });

  bool isLoading;
  Function sumbmitToDataBase;
  String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : buildPaymentOption(
                text: 'Cash on employee',
                icon: Icons.payment,
                checkOut: () async {
                  await sumbmitToDataBase();
                },
              ),
        SizedBox(height: Constants.screenHeight * 0.023),
        isLoading == true
            ? const SizedBox()
            : buildPaymentOption(
                text: "Pay with visa",
                checkOut: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentView(
                            onPaymentSuccess: () {},
                            price: double.tryParse(price) ?? 100,
                            onPaymentError: () {}),
                      ));
                }),
        SizedBox(
          height: Constants.screenHeight * 0.023,
        ),
      ],
    );
  }

  Widget buildPaymentOption(
      {required String text, IconData? icon, required Function checkOut}) {
    return InkWell(
      onTap: () {
        checkOut();
      },
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Constants.screenHeight * 0.006,
              horizontal: Constants.screenWidth * 0.03),
          decoration: BoxDecoration(
            border:
                Border.all(color: AppColors.primary.withOpacity(0.6), width: 2),
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon != null
                  ? Row(
                      children: [
                        SizedBox(
                          width: Constants.screenWidth * 0.02,
                        ),
                        Icon(
                          Icons.payment,
                          color: AppColors.primary,
                          size: Constants.screenWidth * 0.06,
                        ),
                      ],
                    )
                  : SvgPicture.asset(
                      "assets/images/visa.svg",
                      height: Constants.screenHeight * 0.04,
                      width: Constants.screenWidth * 0.04,
                    ),
              SizedBox(
                width: Constants.screenWidth * 0.05,
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: Constants.screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
