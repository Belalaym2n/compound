import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code/data/repositires/request_order/booking_order_car_wash_repo.dart';
import 'package:qr_code/data/services/shared_pref_helper.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/utils/base.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../../domain/models/booking_model.dart';
import '../../../../ui/sharedWidgets/build_step_in_steeper.dart';
import '../connector/car_wash_connector.dart';

class CarWashViewModel extends BaseViewModel<CarWashConnector> {
  int index = 0;
  String? bookingType;
  bool _isLoading = false;
  bool _orderIsDone = false;

  // Getters
  bool get isLoading => _isLoading;

  bool get orderIsDone => _orderIsDone;
  List<DateTime> selectedDates = [];

  String _price = '';

  String get price => _price;

  changePrice(String price) {
    _price = price;
    notifyListeners();
  }

  final CarWashBookingRepo carWashBookingRepo;

  CarWashViewModel(this.carWashBookingRepo);

  Future<void> uploadBooking({
    required BuildContext context,
    required String name,
    required String phoneNumber,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      Booking booking = Booking(
        name: name,
        price: _price,
        isPaid: 'un paid',
        email: SharedPreferencesHelper.email.toString(),
        phoneNumber: phoneNumber,
        compound: SharedPreferencesHelper.compoundName.toString(),
        bookingType: bookingType,
        selectedDates: selectedDates
            .map((date) => BookingDate(
                  date: DateFormat('yyyy-MM-dd').format(date),
                  isDone: false,
                ))
            .toList(),
      );

      // Upload booking
      await carWashBookingRepo.upload_order(
        booking: booking,
        context: context,
      );

      _isLoading = false;
      _orderIsDone = true;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      error_widget(context: context, message: e.toString());
    }
  }

  void onStepCancel() {
    if (index > 0) {
      index -= 1;
      notifyListeners();
    }
  }

  void onStepContinue({
    required TextEditingController phoneController,
    required TextEditingController nameController,
    required BuildContext context,
  }) async {
    if (index == 0) {
      if (bookingType == null) {
        connector?.onError("Please choose your booking type");
        return;
      }
      _moveToNextStep();
      return;
    }

    if (index == 1) {
      if ((bookingType == 'day' && selectedDates.length == 1) ||
          (bookingType == 'month' && selectedDates.length == 8)) {
        _moveToNextStep();
        return;
      }

      final errorMessage = bookingType == 'month'
          ? "Please choose 8 days"
          : "Please choose a day";
      connector?.onError(errorMessage);
      return;
    }

    if (index == 2) {
      if (_checkFieldsNotNull(
        phoneController: phoneController,
        nameController: nameController,
      )) {
        await SharedPreferencesHelper.saveData(
            key: "phone", value: phoneController.text.trim());
        await SharedPreferencesHelper.saveData(
            key: "name", value: nameController.text.trim());

        _moveToNextStep();
        return;
      }
      connector?.onError("Phone number and name must not be empty");
      return;
    }
  }

  void _moveToNextStep() {
    index += 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  bool _checkFieldsNotNull({
    required TextEditingController phoneController,
    required TextEditingController nameController,
  }) {
    return phoneController.text.isNotEmpty && nameController.text.isNotEmpty;
  }

  List<Step> get steps => [
        buildStep(
          colorIndex: index > 0,
          isActive: index > 0,
          tittleName: connector!.tittleName("Choose Booking"),
          content: connector!.step_one_content(),
          isCurrentStep: index == 0,
        ),
        buildStep(
          colorIndex: index > 1,
          isActive: index > 1,
          content: connector!.step_two_content(),
          isCurrentStep: index == 1,
          tittleName: connector!.tittleName("Booking Day"),
        ),
        buildStep(
          colorIndex: index > 2,
          isActive: index > 2,
          tittleName: connector!.tittleName("Contact Information"),
          content: connector!.step_three_content(),
          isCurrentStep: index == 2,
        ),
        buildStep(
          colorIndex: index > 3,
          isActive: index > 3,
          tittleName: connector!.tittleName("Checkout"),
          content: connector!.final_step_content(),
          isCurrentStep: index == 3,
        ),
      ];

  void selectBookingType(String type) {
    bookingType = type;
    selectedDates.clear(); // Reset dates on type change
    notifyListeners();
  }

  void toggleDateSelection(DateTime date) {
    if (selectedDates.contains(date)) {
      selectedDates.remove(date);
    } else if (bookingType == 'month' && selectedDates.length < 8) {
      selectedDates.add(date);
    } else if (bookingType == 'day' && selectedDates.isEmpty) {
      selectedDates.add(date);
    }
    notifyListeners();
  }

  bool isSelected(DateTime date) => selectedDates.contains(date);

  Future<void> saveImage({
    required ScreenshotController screenshotController,
    required BuildContext context,
  }) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String message = '';

    try {
      final dir = await getTemporaryDirectory();
      var filename =
          '${dir.path}/SaveImage_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filename);

      // Capture the screenshot
      final imageBytes = await screenshotController.capture();
      if (imageBytes == null) {
        throw Exception("Failed to capture the screenshot: imageBytes is null");
      }

      // Log the size of the captured image
      print("Captured image size: ${imageBytes.length} bytes");

      await file.writeAsBytes(imageBytes);

      //       // Save the file using FlutterFileDialog
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk at $finalPath';
      } else {
        throw Exception("File saving was cancelled");
      }
    } catch (e) {
      message = 'Error: ${e.toString()}';
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFe91e63),
      ));
      return; // Exit early on error
    }

    connector!.success_widget();
    // If successful, show a success message
  }
}
