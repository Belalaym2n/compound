import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'app_colors.dart';

Widget shimmerEffect_advs({
  required double height,
  required double width,
}) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder for the image
          Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: height * 0.46,
                // نسبة ارتفاع الصورة بالنسبة للارتفاع الكلي
                width: width,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              )),
          SizedBox(height: 8),
          // Placeholder for the title text
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 16,
              width: width * 0.7,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 8),
          // Placeholder for the description text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 16,
                  width: width * 0.5,
                  color: Colors.grey[300],
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Icon(
                  Icons.ads_click,
                  color: AppColors.primary,
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget notification_not_exist_shimmer({
  required double height,
  required double width,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
                child: const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notification_important,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      "Wait  for last notification",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
