import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';

class ChooseCompound extends StatefulWidget {
  Function changeExpanded;
  Function changeCompoundName;
  Function changeIndex;
  int selectedCompoundIndex;
  bool isExpanded;

  ChooseCompound(
      {required this.changeExpanded,
      required this.changeCompoundName,
      required this.changeIndex,
      required this.selectedCompoundIndex,
      required this.isExpanded});

  @override
  State<ChooseCompound> createState() => _ChooseCompoundState();
}

class _ChooseCompoundState extends State<ChooseCompound> {
  @override
  Widget build(BuildContext context) {
    const List<String> compounds = [
      "Madinate el galala",
      "LA Mirada",
      "Maadi",
      "koronfol",
    ];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: widget.isExpanded
          ? Constants.screenHeight * 0.35
          : Constants.screenHeight * 0.08,
      width: Constants.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Constants.screenHeight * 0.02,
                  horizontal: Constants.screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose Compound",
                    style: TextStyle(
                      fontSize: Constants.screenWidth * 0.045,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.changeExpanded();
                    },
                    child: AnimatedRotation(
                      turns: widget.isExpanded ? 0.5 : 0,
                      // Rotation animation for arrow
                      duration: Duration(milliseconds: 300),
                      child: Icon(
                        widget.isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.primary,
                        size: Constants.screenWidth * 0.07,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded Content
            AnimatedOpacity(
              opacity: widget.isExpanded ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: widget.isExpanded
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.screenWidth * 0.05,
                          vertical: Constants.screenHeight * 0.01),
                      child: Column(
                        children: compounds
                            .asMap()
                            .entries
                            .map((entry) =>
                                buildCompoundItem(entry.key, entry.value))
                            .toList(),
                      ),

                      // Dynamically pass the rule widget
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCompoundItem(int index, String compoundName) {
    final bool isSelected = index == widget.selectedCompoundIndex;

    return GestureDetector(
      onTap: () {
        widget.changeIndex(index);
        widget.changeCompoundName(compoundName);
        print(compoundName); // تحديث العنصر المختار
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Constants.screenHeight * 0.01),
        height: Constants.screenHeight * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          compoundName,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: Constants.screenWidth * 0.04,
          ),
        ),
      ),
    );
  }
}
