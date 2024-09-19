import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:qr_code/models/in%20document.dart';
import 'package:qr_code/models/messageModel.dart';
import 'package:qr_code/shared/remote/notification_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModelChat extends ChangeNotifier {
  ApiNotification apiNotification = ApiNotification();

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      {required String conversationId}) {
    return FirebaseFirestore.instance
        .collection('Conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  sendMessageToDatabase({
    required String id,
    required String senderId,
    required String message,
    required String image,
    BuildContext? context,
  }) async {
    String text = "${DateTime.now()}";

    MessageModel messageModel = MessageModel(
        image: image,
        message: message,
        timestamp: DateTime.now().toString(),
        name: id,
        senderId: senderId);

    LastMessageModel documentsField = LastMessageModel(
      message,
      id,
      DateTime.now().toString(),
    );

    final firestore =
        FirebaseFirestore.instance.collection('Conversations').doc(id);
    await firestore.set(documentsField.toJson());

    await firestore.collection('messages').add(messageModel.toJson());

    await firestore.update(documentsField.toJson());
    await sendNotificationToAdmin(
      receiverId: "123",
      message: message,
      context: context,
    );
  }

  checkIsUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString("Id");
    return name;
  }

  Future<void> sendNotificationToAdmin({
    required String receiverId,
    required String message,
    required BuildContext? context,
  }) async {
    try {
      String adminId = await getAdminId(receiverId: "123");
      Response response = await apiNotification.post_data(
          adminId: getDeviceId().toString(), message: message);
      if (response.statusCode == 200) {
        print('تم إرسال الإشعار بنجاح');
      } else {
        print('فشل إرسال الإشعار: ${response.body}');
      }
    } catch (e) {
      print('خطأ في إرسال الإشعار: $e');
    }
  }

  String? getDeviceId() {
    String? deviceId = OneSignal.User.pushSubscription.id;
    print("Device id:$deviceId");
    return deviceId;
  }

  getAdminId({required String receiverId}) async {
    DocumentSnapshot adminDoc = await FirebaseFirestore.instance
        .collection('Admin')
        .doc(receiverId)
        .get();

    // التحقق مما إذا كان المستند موجودًا
    if (!adminDoc.exists) {
      print('لم يتم العثور على مستند الإداري للمعرف: $receiverId');
      return; // الخروج من الدالة إذا كان المستند غير موجود
    }

    String adminPlayerId = adminDoc['player_id'];
    return adminPlayerId;
  }

  openGallery(
    String id,
    String senderId,
  ) async {
    final picker = ImagePicker();
    final pickedImage = (await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 60));

    if (pickedImage == null) {
      return;
    }
    await uploadImage(File(pickedImage.path), id);
    String image = await uploadImage(File(pickedImage.path), id);
    sendMessageToDatabase(
        id: id, senderId: senderId, image: image, message: '');
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
}
