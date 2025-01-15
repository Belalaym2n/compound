import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

Step buildStep({
  required bool colorIndex,
  required bool isActive,
  required Widget content,
  required Widget tittleName,
  required bool isCurrentStep,
}) {
  return Step(
    stepStyle: StepStyle(
      indexStyle: TextStyle(
        color: colorIndex ? Colors.white : AppColors.primary,
      ),
      color: AppColors.primary,
    ),
    isActive: isActive,
    title: AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        fontSize: isCurrentStep ? 18 : 14,
        fontWeight: FontWeight.bold,
        color: isCurrentStep ? AppColors.primary : Colors.grey,
      ),
      child: tittleName,
    ),
    content: Column(
      children: [content],
    ),
  );
}
