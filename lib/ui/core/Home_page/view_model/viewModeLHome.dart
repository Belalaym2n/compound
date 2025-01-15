import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewModelHome extends ChangeNotifier {
  int _selectedIndex = -1;
  String? _name;

  int get selectedIndex => _selectedIndex;

  String? get name => _name;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllAdV() {
    return FirebaseFirestore.instance.collection('For rent').get();
  }

  void selectIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify listeners to update the UI
  }

//be@gmail.com 1234567
}
