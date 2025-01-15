import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

Widget choose_widget({
  String? ruleName,
  required String groupValue,
  required Function(String value) onChanged,
}) {
  return Row(
    children: [
      Radio<String>(
        value: ruleName ?? '',
        groupValue: groupValue,
        onChanged: (value) {
          onChanged(value!);
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
