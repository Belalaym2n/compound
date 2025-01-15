import 'package:flutter/material.dart';
import 'package:qr_code/data/repositires/request_order/booking_order_car_wash_repo.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';
import 'package:qr_code/utils/base.dart';

import '../../../ui/sharedWidgets/build_step_in_steeper.dart';
import '../connector/car_wash_connector.dart';

class CarWashViewModel extends BaseViewModel<CarWashConnector> {
  int index = 0;
  String? bookingType;
  bool _isLoading = false;
  bool _orderIsDone = false;

  bool get isLoading => _isLoading;

  bool get orderIsDone => _orderIsDone;
  List<DateTime> selectedDates = [];

  CarWashBookingRepo carWashBookingRepo;

  CarWashViewModel(this.carWashBookingRepo);

  void onStepCancel() {
    if (index > 0) {
      index = index - 1;
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
        connector?.onError("Please choose your booking");
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
          tittleName: connector!.tittleName("Booking day"),
        ),
        buildStep(
          colorIndex: index > 2,
          isActive: index > 2,
          tittleName: connector!.tittleName("Contact information"),
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

  Future<void> uploadSelectedDates(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await carWashBookingRepo.upload_order(
          selectedDates: selectedDates,
          bookingType: bookingType,
          context: context);
      _isLoading = false;
      _orderIsDone = true;
      notifyListeners();
      print('Dates uploaded successfully to Firestore!');
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      error_widget(context: context, message: e.toString());
    }
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
}
