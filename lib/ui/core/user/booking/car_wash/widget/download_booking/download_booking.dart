import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/elevated_button.dart';
import 'package:qr_code/utils/constants.dart';
import 'package:screenshot/screenshot.dart';

import 'day_card.dart';

class BookingDaysDonwload extends StatelessWidget {
  List<DateTime> selectDates;
  String name;
  String phoneNumber;
  ScreenshotController screenshotController;

  Function() saveImage;

  BookingDaysDonwload(
      {required this.selectDates,
      required this.name,
      required this.screenshotController,
      required this.saveImage,
      required this.phoneNumber});

  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Screenshot(
            controller: screenshotController,
            child: Container(
              color: Color(0xFFF5F5F5),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  build_booking_data(
                      bookingData: name, dataName: 'Booking name: '),
                  build_booking_data(
                      bookingData: phoneNumber, dataName: 'Phone Number: '),
                  build_booking_data(
                      bookingData: "un paid ", dataName: 'is paid ? '),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(selectDates.length, (index) {
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          String day = "${index + 1}";
                          List<Map<String, dynamic>> datesWithStatus =
                              selectDates.map((date) {
                            return {
                              'date': formatter.format(date),
                              'day': "day $day",
                            };
                          }).toList();
                          return DayCard(
                            day: datesWithStatus[index]["day"],
                            date: datesWithStatus[index]["date"].toString(),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // ElevatedButton is now outside the Screenshot widget
        Padding(
          padding: const EdgeInsets.all(16),
          child: elevated_button(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  saveImage();
                });
              },
              buttonName: "download booking"),
        )
      ],
    );
  }
}

build_booking_data({
  required String bookingData,
  required String dataName,
}) {
  return Container(
      width: Constants.screenWidth,
      margin: EdgeInsets.only(
        bottom: Constants.screenWidth * 0.045,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Constants.screenWidth * 0.045,
        vertical: Constants.screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.screenWidth * 0.025),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            dataName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Constants.screenWidth * 0.04,
              color: Color(0xFF757575),
            ),
          ),
          Text(
            bookingData,
            style: TextStyle(
              fontSize: Constants.screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ));
}
