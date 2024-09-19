import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code/screens/screensForUser/get_all_forRent/rent_connector.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Home_page/widget_home.dart';

class ForRentViewModel extends ChangeNotifier {
  late RentConnector connector;

  Future<QuerySnapshot<Map<String, dynamic>>> callApiForRent() {
    return FirebaseFirestore.instance.collection('For rent').get();
  }

  Future<void> openWhatsApp(String phoneNumber, String message) async {
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open WhatsApp.';
    }
  }

  getAllForRent({
    required double screenHeight,
    required double screenWidth,
  }) {
    return FutureBuilder(
        future: callApiForRent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return connector.loading(); // Loading indicator
          } else if (snapshot.hasError) {
            // print(snapshot.error.toString());
            return connector.errorMessage(
                "snapshot.hasError.toString()", context); // Error handling
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('No Advs found')); // Empty list handling
          } else {
            final Advs = snapshot.data!.docs;
            return Expanded(
              child: GridView.builder(
                //     shrinkWrap: true,
                itemCount: Advs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:
                      (screenWidth / 2.35) / (screenHeight * 0.19),
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  final advs = Advs[index];

                  return products(
                      context: context,
                      tittle: advs['tittle'].toString(),
                      description: advs['description'].toString(),
                      imageUrl: advs['image'],
                      screenHeight: screenHeight,
                      screenWidth: screenWidth);
                },
              ),
            );
          }
        });
  }
}
