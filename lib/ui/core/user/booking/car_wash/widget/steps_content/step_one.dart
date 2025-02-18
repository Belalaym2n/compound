import 'package:flutter/material.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../../../utils/app_colors.dart';

class StepOne extends StatelessWidget {
  StepOne({
    super.key,
    required this.selectBookingType,
    required this.changePrice,
    required this.bookingType,
  });

  String bookingType;
  Function selectBookingType;
  Function changePrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // يضمن توزيع العناصر بشكل متساوٍ
          children: [
            Expanded(
              // يمنع ListTile من أخذ كل المساحة
              child: ListTile(
                title: const Text('Book a Day'),
                leading: Radio<String>(
                    activeColor: AppColors.primary,
                    value: 'day',
                    groupValue: bookingType,
                    onChanged: (value) {
                      selectBookingType(value!);
                      changePrice('400');
                    }),
              ),
            ),
            Text(
              "100",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Constants.screenWidth * 0.04),
            ), // يعرض النص على الجانب الأيمن
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                title: const Text('Book a Month'),
                leading: Radio<String>(
                    activeColor: AppColors.primary,
                    value: 'month',
                    groupValue: bookingType,
                    onChanged: (value) {
                      selectBookingType(value!);
                      changePrice('400');
                    }),
              ),
            ),
            Text(
              "400",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Constants.screenWidth * 0.04),
            ),
          ],
        ),
      ],
    );
  }
}
