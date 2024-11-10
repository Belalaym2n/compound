import 'package:flutter/material.dart';

import '../../../models/stores_name.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/widgets.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({
    super.key,
    required this.sources,
    required this.screenHeight,
    required this.screenWidth,
  });

  List<StoresName> sources;
  double screenHeight;
  double screenWidth;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

int index = 0;

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.sources.length,
            child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                labelPadding: EdgeInsets.only(left: 13, right: 14),
                onTap: (value) {
                  index = value;
                  setState(() {});
                },
                tabs: widget.sources
                    .map(
                      (source) => source_item(
                          text: source.name,
                          isSelected: widget.sources.indexOf(source) == index),
                    )
                    .toList())),
        SizedBox(
          height: widget.screenHeight * 0.01,
        ),
        storeItem(
            screenWidth: widget.screenWidth, screenHeight: widget.screenHeight),
        storeItem(
            screenWidth: widget.screenWidth, screenHeight: widget.screenHeight),
        storeItem(
            screenWidth: widget.screenWidth, screenHeight: widget.screenHeight),
        storeItem(
            screenWidth: widget.screenWidth, screenHeight: widget.screenHeight),
        storeItem(
            screenWidth: widget.screenWidth, screenHeight: widget.screenHeight),
      ],
    );
  }

  Widget source_item({
    required String text,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(widget.screenWidth * 0.03),
        border: Border.all(color: AppColors.primary, width: 1.6),
      ),
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : AppColors.primary),
      ),
    );
  }
}
