import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code/models/messageModel.dart';

class UploadToDatabase{

 static uploadToCollection({required String collectionName,
   required String nameUser,
   required Map<String,dynamic>data}){
    FirebaseFirestore.instance.collection(collectionName).doc(nameUser).set(data);
  }



}