import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/screensForUser/Home_page/widget_home.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../models/owner_login.dart';

class ViewModelHome extends ChangeNotifier {
  int _selectedIndex = -1;
  String? _name;

  int get selectedIndex => _selectedIndex;

  String? get name => _name;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllAdV() {
    return FirebaseFirestore.instance.collection('For rent').get();
  }

  Future<void> loadUserName() async {
    OwnerDetails ownerDetails = OwnerDetails();
    String? retrievedName = await ownerDetails.getUserName();

    _name = retrievedName;
    notifyListeners();
  }

  void selectIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify listeners to update the UI
  }

  for_rent({required double screenHeight, required double screenWidth}) {
    return SizedBox(
        height: screenHeight * 0.24,
        child: FutureBuilder(
            future: getAllAdV(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    // Number of shimmer placeholders
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: screenWidth * 0.5,
                        child: Skeletonizer(
                            child: products(
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                                context: context,
                                tittle: "advs['tittle'].toString()",
                                description: "advs['description'].toString()",
                                imageUrl:
                                    "https://th.bing.com/th/id/OIP.thxvwuvNfiwNZCL1m79IxgHaEb?w=306&h=183&c=7&r=0&o=5&dpr=1.4&pid=1.7")),
                      );
                    });
              }
              //
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 7, vertical: 14),
              //   child: shimmerEffect_advs(
              //     height: screenHeight * 0.25,
              //     width: screenWidth * 0.5,
              //   ),
              // );

              else if (snapshot.hasError) {
                // print(snapshot.error.toString());
                return Center(
                    child: Text('Error: ${snapshot.error}')); // Error handling
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text('No ADV found')); // Empty list handling
              } else {
                final Advs = snapshot.data!.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Advs.length,
                  itemBuilder: (context, index) {
                    final advs = Advs[index];

                    return SizedBox(
                      width: screenWidth * 0.5,
                      child: products(
                          tittle: advs['tittle'].toString(),
                          description: advs['description'].toString(),
                          imageUrl: advs['image'],
                          context: context,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth),
                    );
                  },
                );
              }
            }));
  }
//be@gmail.com 1234567
}
