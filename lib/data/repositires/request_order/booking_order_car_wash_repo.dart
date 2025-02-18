import 'package:flutter/cupertino.dart';
import 'package:qr_code/data/services/data_base/booking/upload_booking_service.dart';
import 'package:qr_code/domain/models/booking_model.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';

class CarWashBookingRepo {
  UploadBookingDatabaseService bookingDatabaseService;

  CarWashBookingRepo(this.bookingDatabaseService);

  Stream<List<Booking>>? get_order({required DateTime date}) {
    return bookingDatabaseService.fetchBookingsStream(
        date: date); // Fetch bookings based on the date
  }

  Future<void> upload_order(
      {required Booking booking, required BuildContext context}) async {
    try {
      await bookingDatabaseService.uploadBooking(booking);
    } catch (e) {
      error_widget(context: context, message: e.toString());
    }
  }

  update_order({
    required String id,
    required DateTime date,
  }) async {
    await bookingDatabaseService.updateIsDoneInSelectedDates(id, date);
  }
}
