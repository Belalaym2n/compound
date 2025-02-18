import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/constants.dart';

class StepOneContent extends StatelessWidget {
  StepOneContent({
    super.key,
    required this.chooseProblem,
    required this.changePrice,
    required this.problemSelected,
  });

  Function chooseProblem;
  Function changePrice;
  String problemSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            problemWidget(
              price: "100",
              changePrice: changePrice(),
              onChanged: chooseProblem(),
              groupValue: problemSelected,
              problemName: '7shrat',
            ),
            Text(
              "100\$",
              style: TextStyle(
                  fontSize: Constants.screenWidth * 0.03,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            problemWidget(
              price: "200",
              changePrice: changePrice(),
              onChanged: chooseProblem(),
              groupValue: problemSelected,
              problemName: '7aga tanya',
            ),
            Text("200\$")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            problemWidget(
              price: "300",
              changePrice: changePrice(),
              onChanged: chooseProblem(),
              groupValue: problemSelected,
              problemName: '7aga tanya and 7shrat',
            ),
            Text("300\$")
          ],
        ),
      ],
    );
  }

  Widget problemWidget({
    String? problemName,
    required String price,
    required Function(String price) changePrice,
    required String groupValue,
    required Function(String value) onChanged,
  }) {
    return Row(
      children: [
        Radio<String>(
          value: problemName ?? '',
          groupValue: groupValue,
          onChanged: (value) {
            onChanged(value!);

            changePrice(price);
          },
          activeColor: AppColors.primary,
        ),
        Text(
          problemName ?? "",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
              fontSize: Constants.screenWidth * 0.04),
        ),
      ],
    );
  }
}
