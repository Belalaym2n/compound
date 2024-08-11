import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetAllAdvsViewModel extends ChangeNotifier{
  Future<QuerySnapshot<Map<String, dynamic>>> getMessage(
      ) {
    return FirebaseFirestore.instance
        .collection('For rent').

    get();
  }
}