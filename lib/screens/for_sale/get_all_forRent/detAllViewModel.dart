import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class GetAllAdvsViewModel extends ChangeNotifier {
  Future<QuerySnapshot<Map<String, dynamic>>> getMessage() {
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
}
