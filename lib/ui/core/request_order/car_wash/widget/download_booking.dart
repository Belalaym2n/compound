import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class DayListScreen extends StatelessWidget {
  final List<Map<String, String>> days = [
    {"day": "Day 1", "date": "14/7/2024"},
    {"day": "Day 2", "date": "15/7/2024"},
    {"day": "Day 3", "date": "16/7/2024"},
    {"day": "Day 4", "date": "17/7/2024"},
    {"day": "Day 5", "date": "18/7/2024"},
    {"day": "Day 6", "date": "19/7/2024"},
    {"day": "Day 7", "date": "20/7/2024"},
    {"day": "Day 8", "date": "21/7/2024"},
  ];
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Container(
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with your dynamic data
                itemBuilder: (context, index) {
                  return DayCard(
                    day: 'Day $index',
                    date: '2025-01-${index + 1}',
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _captureAndSave,
              child: Text("Capture and Save Screenshot"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _captureAndSave() async {
    // // Capture the screenshot
    // screenshotController.capture().then((image) async {
    //   // Get the temporary directory
    //   final directory = await getExternalStorageDirectory();
    //   final imagePath = '${directory!.path}/screenshot.png';
    //
    //   // Save the image to the gallery
    //   final result = await ImageGallerySaver.saveFile(imagePath);
    //   if (result != null) {
    //     print('Screenshot saved to gallery');
    //   }
    // }).catchError((onError) {
    //   print(onError);
    // });
  }
}

class DayCard extends StatelessWidget {
  final String day;
  final String date;

  DayCard({required this.day, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
          Icon(
            Icons.calendar_today,
            color: Color(0xFFB2D9DB), // Accent color
          ),
        ],
      ),
    );
  }
}
