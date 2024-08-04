import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code/models/in%20document.dart';
import 'package:qr_code/models/messageModel.dart';
import 'package:qr_code/screens/admin_panel/uploadForFirebaseDatabse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModelChat extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      {required String conversationId}) {
    return FirebaseFirestore.instance
        .collection('Conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp',descending: true)
        .snapshots();
  }



  Future<void> sendMessageTo(
      {required String id,
        required String senderId,
        required String message}) async {
    String text = "${DateTime.now()}";

    MessageModel messageModel = MessageModel(
        message: message, timestamp:
    DateTime.now().toString(),
        name: id, senderId: senderId);


    DocumentsField documentsField=DocumentsField(message, id,
        DateTime.now().toString());

    final firestore = FirebaseFirestore.instance.
    collection('Conversations').doc(id);
    await firestore.set(documentsField.toJson());



    await firestore
        .collection('messages')
        .add(messageModel.toJson());

    await firestore.update(documentsField.toJson());
  }


}


