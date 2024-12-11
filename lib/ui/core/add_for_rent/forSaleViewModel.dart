import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/forRentModel.dart';
import 'uploadForFirebaseDatabse.dart';

class ViewModelForSale extends ChangeNotifier {
  File? _imageFile;
  String? _imageUrl;

  File? get imageFile => _imageFile;

  String? get imageUrl => _imageUrl;

  openGallery() async {
    final picker = ImagePicker();
    final pickedImage = (await picker.pickImage(source: ImageSource.gallery));

    if (pickedImage == null) {
      return;
    }
    _imageFile = File(pickedImage.path);

    uploadImage(_imageFile!);
    String url = await uploadImage(_imageFile!);
    _imageUrl = url;

    //notifyListeners();
  }

  uploadImage(File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('ForSale/admin/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return taskSnapshot.ref.getDownloadURL();
  }

  uploadToDataBase({
    required String image,
    required String tittle,
    required String description,
  }) {
    ForRentmodel forRentmodel =
        ForRentmodel(image: image, tittle: tittle, description: description);
    UploadToDatabase.uploadToCollection(
        collectionName: 'For rent',
        nameUser: 'admin${DateTime.now()}',
        data: forRentmodel.toJson());
  }

  SDJF() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<ForRentmodel>(
      fromFirestore: (snapshot, _) {
        return ForRentmodel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }
}
