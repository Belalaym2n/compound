import 'package:flutter/cupertino.dart';
import 'package:qr_code/data/services/data_base/booking/upload_booking_service.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';

class CarWashBookingRepo {
  UploadBookingDatabaseService uploadBookingDatabaseService;

  CarWashBookingRepo(this.uploadBookingDatabaseService);

  Future<void> upload_order(
      {required List<DateTime> selectedDates,
      required String? bookingType,
      required BuildContext context}) async {
    try {
      await uploadBookingDatabaseService.uploadSelectedDates(
          selectedDates: selectedDates,
          bookingType: bookingType,
          context: context);
    } catch (e) {
      error_widget(context: context, message: e.toString());
    }
  }
}
