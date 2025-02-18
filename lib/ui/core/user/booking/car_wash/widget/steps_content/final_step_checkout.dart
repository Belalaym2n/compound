import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/user/Orders/checkoutOption/checkOutOption.dart';

import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/constants.dart';

class FinalStepCheckoutCarWash extends StatelessWidget {
  FinalStepCheckoutCarWash({
    super.key,
    required this.submitToDataBase,
    required this.isLoading,
    required this.price,
  });

  bool isLoading;
  Function submitToDataBase;
  String price;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Column(
            children: [
              SizedBox(
                height: Constants.screenHeight * 0.05,
              ),
              CircularProgressIndicator(
                color: AppColors.primary,
              ),
              SizedBox(
                height: Constants.screenHeight * 0.05,
              ),
            ],
          )
        : CheckOutOption(
            sumbmitToDataBase: submitToDataBase,
            price: price,
            isLoading: isLoading);
  }
}
