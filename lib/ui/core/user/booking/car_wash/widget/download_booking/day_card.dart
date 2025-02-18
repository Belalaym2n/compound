import 'package:flutter/material.dart';

import '../../../../../../../utils/constants.dart';

class DayCard extends StatelessWidget {
  final String day;
  final String date;

  DayCard({required this.day, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Constants.screenWidth * 0.025,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Constants.screenWidth * 0.045,
        vertical: Constants.screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Constants.screenWidth * 0.04,
                  color: Color(0xFF757575),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                date,
                style: TextStyle(
                  fontSize: Constants.screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          Icon(
            Icons.calendar_today,
            size: Constants.screenWidth * 0.06,
            color: Color(0xFFB2D9DB), // Accent color
          ),
        ],
      ),
    );
  }
}
