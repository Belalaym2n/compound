import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/domain/models/order_data.dart';
import 'package:qr_code/ui/core/request_order/best_controller/connector/best_controller_connector.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/repositires/request_order/best_controller_order_repo.dart';
import '../../../../../data/services/shared_pref_helper.dart';
import '../../../ui/sharedWidgets/build_step_in_steeper.dart';

class BestControllerViewModel extends BaseViewModel<BestControllerConnector> {
  int index = 0;
  String _problem = '';
  bool _isLoading = false;
  bool _orderIsDone = false;

  bool get isLoading => _isLoading;

  bool get orderIsDone => _orderIsDone;

  String get problem => _problem;
  BestControllerOrderRepo orderRepo;

  BestControllerViewModel(this.orderRepo);

  chooseProblem(String problem) {
    _problem = problem;
    notifyListeners();
  }

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
      int milliseconds = DateTime.now().millisecondsSinceEpoch;
      DateTime date =
          DateUtils.dateOnly(DateTime.fromMillisecondsSinceEpoch(milliseconds));

      OrderData bestControllerOrderModel = OrderData(
          compoundName: SharedPreferencesHelper.compoundName,
          service: 'Best Controller',
          problem: _problem,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          note: noteController.text.trim(),
          address: addressController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          area: areaController.text.trim(),
          time: DateTime.now().toString(),
          isPaid: "un paid",
          email: 'belalscg@gmil.com');
      await orderRepo.send_order_for_database(
          bestControllerOrder: bestControllerOrderModel);
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
