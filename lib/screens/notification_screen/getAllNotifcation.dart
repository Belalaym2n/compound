
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/notification_screen/notification_screen.dart';
import 'package:qr_code/utils/app_colors.dart';
import '../../models/notification_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'All Notifications',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.05),
        ),
      ),
      body: Column(
        children: [
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
        imageUrl:notification.image);
    },
    );}
          } ))
        ],
      ),
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
                  tittle: tittle, imageUrl: imageUrl!, description: description),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.primary,
            ),
            width: screenWidth,
            height: screenHeight * 0.12,
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Image.network(imageUrl!, width: 50,
                  height: 50, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print(error);
                    // Display a placeholder image if the network image fails to load
                    return Icon(Icons.error, size: 50,color: AppColors.primary,);
                  },
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
                      "${ tittle.length>10? tittle.substring(0,10):tittle}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w700),
                    ),
                    Text('${description.length>10?description.substring(0,10):description}',
                        maxLines: 1, style: TextStyle(color: Colors.white))
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.2,
                ),
                Expanded(
                    child: Icon(
                  Icons.notification_add,
                  color: Colors.white,
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
