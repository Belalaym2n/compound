import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/Home_page/widget_home.dart';

import '../../models/notification_model.dart';


class ViewModelHome extends ChangeNotifier{



  Future<QuerySnapshot<Map<String, dynamic>>> getAllAdV(
      ) {
    return FirebaseFirestore.instance
        .collection('For rent').

    get();
  }

  getNotification(BuildContext context){
  Expanded(
        child:  FutureBuilder<List<NotificationModel>>(
            future: NotificationService.getNotifications(), // Call your getNotifications function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // Loading indicator
              } else if (snapshot.hasError) {
                // print(snapshot.error.toString());
                return Center(child: Text('Error: ${snapshot.error}')); // Error handling
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No notifications  found')); // Empty list handling
              } else {
                final notifications = snapshot.data!;
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    print("${notifications[index].image}");
                    final notification = notifications[index];
                    return notificationItem(tittle:notification.tittle.toString(),
                        description:notification.description ,
                        imageUrl:notification.image, context: context);
                  },
                );}
            } ));
  }


}