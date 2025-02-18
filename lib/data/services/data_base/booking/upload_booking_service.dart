import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/booking_model.dart';
import '../../../../domain/models/id_order_model.dart';

class UploadBookingDatabaseService {
  final bookingsCollection = FirebaseFirestore.instance
      .collection('bookings')
      .withConverter<IDOrderModel>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data()!;
          return Booking.fromJson(data);
        },
        toFirestore: (booking, _) => booking.toJson(),
      );

  Future<void> updateIsDoneInSelectedDates(
      String docId, DateTime targetDate) async {
    try {
      // Fetch the document without using withConverter
      final docSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(docId)
          .get();

      if (docSnapshot.exists) {
        // Extract the raw data as a map
        final data = docSnapshot.data() as Map<String, dynamic>;

        // Parse and update the selectedDates array
        List<dynamic> selectedDates = data['selectedDates'] as List<dynamic>;
        String formattedDate = DateFormat('yyyy-MM-dd').format(targetDate);

        selectedDates = selectedDates.map((dateMap) {
          final map = Map<String, dynamic>.from(dateMap);
          if (map['date'] == formattedDate) {
            map['isDone'] = true; // Update the isDone field to true
          }
          return map;
        }).toList();

        // Save the updated selectedDates back to Firestore
        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(docId)
            .update({
          'selectedDates': selectedDates,
        });

        print("Successfully updated isDone for date: $formattedDate");
      } else {
        print("Document with ID $docId does not exist.");
      }
    } catch (e) {
      print("Error updating isDone in selectedDates: $e");
      rethrow;
    }
  }

  Stream<List<Booking>> fetchBookingsStream({required DateTime date}) {
    try {
      print("Fetching bookings...");
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      return bookingsCollection
          .withConverter<Booking>(
            fromFirestore: (snapshot, _) {
              final data = snapshot.data() as Map<String, dynamic>;
              return Booking.fromJson(
                  data); // Custom conversion of Firestore data to Booking object
            },
            toFirestore: (booking, _) => booking.toJson(),
          )
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .where((doc) {
              final booking = doc.data(); // This is directly a Booking object

              return booking.selectedDates
                  .any((bookingDate) => bookingDate.date == formattedDate);
            })
            .map((doc) => doc.data()) // Map back to Booking object
            .toList(); // Return a list of filtered bookings
      });
    } catch (e) {
      print('Error fetching bookings: $e');
      rethrow;
    }
  }

  Future<void> uploadBooking(IDOrderModel model) async {
    try {
      var docRef = bookingsCollection.doc();

      // Optionally, set the ID in your model before uploading
      model.setId(docRef.id);

      await docRef.set(model);
      print('Booking uploaded successfully!');
    } catch (e) {
      print('Error uploading booking: $e');
      rethrow;
    }
  }
}
