import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/app_images.dart';

import '../../../domain/models/notification_model.dart';
import 'notification_screen.dart';

class GetAllNotifications extends StatefulWidget {
  const GetAllNotifications({super.key});

  @override
  State<GetAllNotifications> createState() => _GetAllNotificationsState();
}

double screenHeight = 0;
double screenWidth = 0;

class _GetAllNotificationsState extends State<GetAllNotifications> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Expanded(
                child: FutureBuilder<List<NotificationModel>>(
                    future: NotificationService.getNotifications(),
                    // Call your getNotifications function
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Loading indicator
                      } else if (snapshot.hasError) {
                        // print(snapshot.error.toString());
                        return Center(
                            child: Text(
                                'Error: ${snapshot.error}')); // Error handling
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: no_notification()); // Empty list handling
                      } else {
                        final notifications = snapshot.data!;
                        return ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            print("${notifications[index].image}");
                            final notification = notifications[index];
                            return notificationItem(
                                tittle: notification.tittle.toString(),
                                description: notification.description,
                                imageUrl: notification.image);
                          },
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }

  Widget no_notification() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.noNotification,
          width: screenWidth * 0.8,
          height: screenHeight * 0.12,
        ),
        Text(
          "No Notifications!",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenWidth * 0.055),
        ),
      ],
    );
  }

  notificationItem({
    required String tittle,
    String? imageUrl,
    required String description,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationScreen(
                  tittle: tittle, imageUrl: imageUrl, description: description),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          elevation: 20,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white38,
            ),
            width: screenWidth,
            height: screenHeight * 0.12,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl!,
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.12,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print(error);
                        // Display a placeholder image if the network image fails to load
                        return Icon(
                          Icons.error,
                          size: 50,
                          color: AppColors.primary,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                  height: screenHeight * 0.02,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      tittle.length > 10 ? tittle.substring(0, 10) : tittle,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                        description.length > 10
                            ? description.substring(0, 10)
                            : description,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.black))
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.2,
                ),
                Expanded(
                    child: Icon(
                  Icons.notification_important,
                  color: Colors.red,
                  size: screenWidth * 0.1,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
