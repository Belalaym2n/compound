import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors.dart';

class HomeServiceOrLandScapeStepOneContent extends StatelessWidget {
  HomeServiceOrLandScapeStepOneContent({
    super.key,
    required this.changeRule,
    required this.changePrice,
    required this.ruleSelected,
  });

  Function changeRule;
  Function changePrice;
  String ruleSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            area_widget(ruleName: '100:150', price: "100"),
            Text("100\$")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            area_widget(ruleName: '150:200', price: "200"),
            Text("200\$")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            area_widget(ruleName: '200 :250', price: "300"),
            Text("300\$")
          ],
        ),
      ],
    );
    ;
  }

  Widget area_widget({String? ruleName, required String price}) {
    return Row(
      children: [
        Radio<String>(
          value: ruleName ?? '',
          groupValue: ruleSelected,
          onChanged: (value) {
            changeRule(value!);
            changePrice(price);
          },
          activeColor: AppColors.primary,
        ),
        Text(
          ruleName ?? "",
          style: TextStyle(color: AppColors.primary),
        ),
      ],
    );
  }
}
