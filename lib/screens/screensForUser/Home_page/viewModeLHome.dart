import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/screensForUser/Home_page/widget_home.dart';

import '../../../models/notification_model.dart';

class ViewModelHome extends ChangeNotifier {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllAdV() {
    return FirebaseFirestore.instance.collection('For rent').get();
  }

  getNotification(BuildContext context) {
    Expanded(
        child: FutureBuilder<List<NotificationModel>>(
            future: NotificationService.getNotifications(),
            // Call your getNotifications function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator()); // Loading indicator
              } else if (snapshot.hasError) {
                // print(snapshot.error.toString());
                return Center(
                    child: Text('Error: ${snapshot.error}')); // Error handling
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child:
                        Text('No notifications  found')); // Empty list handling
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
                      imageUrl: notification.image,
                      context: context,
                      screenHeight: MediaQuery.of(context).size.height,
                      screenWidth: MediaQuery.of(context).size.width,
                    );
                  },
                );
              }
            }));
  }

// getAllAdv({required double screenHeight})=>SizedBox(
//   //* 0.24,
//   height: screenHeight ,
//   child: FutureBuilder(
//       future: getAllAdV(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState ==
//             ConnectionState.waiting) {
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 4, // Number of shimmer placeholders
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 7, vertical: 14),
//                 child: shimmerEffect_advs(
//                   height: screenHeight * 0.25,
//                   width: screenWidth * 0.5,
//                 ),
//               );
//             },
//           );
//         } else if (snapshot.hasError) {
//           // print(snapshot.error.toString());
//           return Center(
//               child: Text(
//                   'Error: ${snapshot.error}')); // Error handling
//         } else if (!snapshot.hasData ||
//             snapshot.data!.docs.isEmpty) {
//           return const Center(
//               child:
//               Text('No ADV found')); // Empty list handling
//         } else {
//           final Advs = snapshot.data!.docs;
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: Advs.length,
//             itemBuilder: (context, index) {
//               final advs = Advs[index];
//
//               return SizedBox(
//                 width: screenWidth * 0.5,
//                 child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 7, vertical: 14),
//                     child: products(
//                         tittle: advs['tittle'].toString(),
//                         description:
//                         advs['description'].toString(),
//                         imageUrl: advs['image'],
//                         context: context,
//                         screenHeight: screenHeight,
//                         screenWidth: screenWidth)),
//               );
//             },
//           );
//         }
//       }),
// ),
}
