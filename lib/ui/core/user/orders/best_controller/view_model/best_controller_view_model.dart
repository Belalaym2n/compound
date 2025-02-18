import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/domain/models/order_data.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../../data/repositires/notification/sendNotifcationRepo.dart';
import '../../../../../../data/repositires/request_order/best_controller_order_repo.dart';
import '../../../../../../data/services/shared_pref_helper.dart';
import '../../../../ui/sharedWidgets/build_step_in_steeper.dart';
import '../connector/best_controller_connector.dart';

class BestControllerViewModel extends BaseViewModel<BestControllerConnector> {
  int index = 0;
  String _problem = '';
  bool _isLoading = false;
  bool _orderIsDone = false;
  String _price = '';

  String get price => _price;

  changePrice(String price) {
    _price = price;
    notifyListeners();
  }

  chooseProblem(String problem) {
    _problem = problem;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  bool get orderIsDone => _orderIsDone;

  String get problem => _problem;
  BestControllerOrderRepo orderRepo;
  SendNotificationRepo sendNotificationRepo;

  BestControllerViewModel(this.orderRepo, this.sendNotificationRepo);

  void onStepCancel() {
    if (index > 0) {
      index = index - 1;
      notifyListeners();
    }
  }

  Future<void> submit_to_database({
    required TextEditingController noteController,
    required TextEditingController phoneController,
    required TextEditingController addressController,
    required TextEditingController areaController,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      OrderData bestControllerOrderModel = OrderData(
          compoundName: SharedPreferencesHelper.compoundName,
          service: 'Best Controller',
          problem: _problem,
          price: _price,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          note: noteController.text.trim(),
          address: addressController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          area: areaController.text.trim(),
          time: DateFormat('HH:mm').format(DateTime.now()),
          isPaid: "un paid",
          email: SharedPreferencesHelper.email);

      await orderRepo.send_order_for_database(
          bestControllerOrder: bestControllerOrderModel);
      try {
        await sendNotificationRepo.sendOrderNotification(
            externalId: "1234", message: "message");
      } catch (e) {
        print("object  $e");
      }

      _isLoading = false;
      _orderIsDone = true;
      notifyListeners();
    } catch (e) {
      connector!.onError(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners(); // تأكد أن الحالة تُحدث دائماً
    }

    // Simulate some work
  }

  onStepContinue({
    required TextEditingController noteController,
    required TextEditingController addressController,
    required TextEditingController phoneNumberController,
    required TextEditingController areaController,
  }) async {
    if (_problem == '') {
      connector!.onError("Please choose your problem");
    } else if (index == 0) {
      index += 1;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } else if (index == 1) {
      bool fieldsAreValid = _checkFieldsNotNull(
        areaController: areaController,
        phoneController: phoneNumberController,
        addressController: addressController,
      );

      if (fieldsAreValid) {
        await SharedPreferencesHelper.saveData(
            key: "phone", value: phoneNumberController.text.trim());
        await SharedPreferencesHelper.saveData(
            key: "area", value: areaController.text.trim());
        await SharedPreferencesHelper.saveData(
            key: "address", value: addressController.text.trim());
        index += 1;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
        print("Index: $index");
      } else {
        connector!
            .onError("address and phone number and area must be not empty ");
      }
    }
  }

  bool _checkFieldsNotNull({
    required TextEditingController phoneController,
    required TextEditingController addressController,
    required TextEditingController areaController,
  }) {
    return phoneController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        areaController.text.isNotEmpty;
  }

  List<Step> get steps => [
        buildStep(
          colorIndex: index > 0,
          isActive: index > 0,
          tittleName: connector!.tittleName("Choose problem"),
          content: connector!.step_one_content(),
          isCurrentStep: index == 0,
        ),
        buildStep(
          colorIndex: index > 1,
          isActive: index > 1,
          content: connector!.step_two_content(),
          isCurrentStep: index == 1,
          tittleName: connector!.tittleName("Contact Information"),
        ),
        buildStep(
          colorIndex: index > 2,
          isActive: index > 2,
          tittleName: connector!.tittleName("Checkout"),
          content: connector!.final_step_content(),
          isCurrentStep: index == 2,
        ),
      ];
}
