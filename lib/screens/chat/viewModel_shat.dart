import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qr_code/models/in%20document.dart';
import 'package:qr_code/models/messageModel.dart';

class ViewModelChat extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      {required String conversationId}) {
    return FirebaseFirestore.instance
        .collection('Conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  sendMessageTo({
    required String id,
    required String senderId,
    required String message,
    required String image,
  }) async {
    String text = "${DateTime.now()}";

    MessageModel messageModel = MessageModel(
        image: image,
        message: message,
        timestamp: DateTime.now().toString(),
        name: id,
        senderId: senderId);

    DocumentsField documentsField = DocumentsField(
      message,
      id,
      DateTime.now().toString(),
    );

    final firestore =
        FirebaseFirestore.instance.collection('Conversations').doc(id);
    await firestore.set(documentsField.toJson());

    await firestore.collection('messages').add(messageModel.toJson());

    await firestore.update(documentsField.toJson());
  }

  openGallery(
    String id,
    String senderId,
  ) async {
    final _picker = ImagePicker();
    final pickedImage = (await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 60));

    if (pickedImage == null) {
      return;
    }
    await uploadImage(File(pickedImage.path), id);
    String image = await uploadImage(File(pickedImage.path), id);
    sendMessageTo(id: id, senderId: senderId, image: image, message: '');
  }

  Future<String> uploadImage(File imageFile, String userId) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('chat_images/$userId/$fileName');
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }

  void sendMessage(String userId, String messageText, String imageUrl) {
    print("belal");
    CollectionReference messages = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('messages');

    messages.add({
      'text': messageText,
      'image': imageUrl, // إضافة رابط الصورة هنا
      'createdAt': Timestamp.now(),
      // يمكنك إضافة المزيد من الحقول حسب احتياجاتك
    });
  }

  Future<void> sendNotification(String playerId, String title, String body,
      String appId, String apiKey) async {
    final String url = 'https://onesignal.com/api/v1/notifications';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $apiKey',
    };

    final message = {
      'app_id': appId,
      'include_player_ids': [playerId],
      'headings': {'en': title},
      'contents': {'en': body},
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully.');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }
}
