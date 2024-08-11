import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class GetAllUserViewModel extends ChangeNotifier{

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      ) {
    return FirebaseFirestore.instance
    .collection('Conversations').

  orderBy('DataTime' ,descending: true).
        snapshots();
  }




}
