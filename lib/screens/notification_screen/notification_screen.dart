import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final String? tittle;
  final String? description;
  final String imageUrl;

  //
  //
  NotificationScreen({
    super.key,
    required this.tittle,
    this.imageUrl = '',
    required this.description,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

double screenHeight = 0;
double screenWidth = 0;

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: screenHeight * 0.04,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.network(
            widget.imageUrl,
            width: screenWidth,
            height: screenHeight * 0.4,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, error, stackTrace) {
              print(error);
              // Display a placeholder image if the network image fails to load
              return const Icon(
                Icons.error,
                size: 50,
                color: Colors.white,
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.tittle!,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: screenWidth * 0.06),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(widget.description!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.03)),
          ),

          // Show image if URL is provided
          const SizedBox(height: 8),
        ]));
  }
}
