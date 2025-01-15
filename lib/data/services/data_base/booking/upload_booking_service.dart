import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';

class UploadBookingDatabaseService {
  Future<void> uploadSelectedDates(
      {required List<DateTime> selectedDates,
      required String? bookingType,
      required BuildContext context}) async {
    try {
      List<Map<String, dynamic>> datesWithStatus =
          convert_to_map(selectedDates: selectedDates);

      await FirebaseFirestore.instance.collection('bookings').doc().set({
        'bookingType': bookingType,
        'selectedDates': datesWithStatus,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Dates uploaded successfully to Firestore!');
    } catch (e) {
      error_widget(context: context, message: e.toString());
      print('Error uploading dates to Firestore: $e');
    }
  }

  List<Map<String, dynamic>> convert_to_map({
    required List<DateTime> selectedDates,
  }) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    List<Map<String, dynamic>> datesWithStatus = selectedDates.map((date) {
      return {
        'date': formatter.format(date),
        'isDone': false,
      };
    }).toList();
    return datesWithStatus;
  }
}
