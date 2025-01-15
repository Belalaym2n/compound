import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/data/repositires/request_order/request_employee_repo.dart';
import 'package:qr_code/domain/models/order_data.dart';
import 'package:qr_code/ui/core/request_order/request_employee/connector/request_employee_connector.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/services/shared_pref_helper.dart';

class RequestEmployeeViewModel extends BaseViewModel<RequestEmployeeConnector> {
  RequestEmployeeRepo requestEmployeeRepo = RequestEmployeeRepo();

  int _selectedIndex = -1;
  bool _isLoading = false;
  bool _isDoneOrder = false;

  int get selectedIndex => _selectedIndex;

  bool get isLoading => _isLoading;

  bool get isDoneOrder => _isDoneOrder;

  void toggleSelection(int index) {
    if (_selectedIndex == index) {
      _selectedIndex = -1; // Deselect the item if it is already selected
    } else {
      _selectedIndex = index; // Select the new item
    }
    notifyListeners(); // Notify the listeners to rebuild the UI
  }

  send_order_to_database({
    required TextEditingController phoneController,
    required TextEditingController addressController,
    required TextEditingController noteController,
    required String employeeName,
  }) async {
    bool fieldsAreValid = _checkFieldsNotNull(
      phoneController: phoneController,
      addressController: addressController,
    );

    if (fieldsAreValid) {
      try {
        _isLoading = true;
        notifyListeners();
        await SharedPreferencesHelper.saveData(
            key: "phone", value: phoneController.text.trim());

        await SharedPreferencesHelper.saveData(
            key: "address", value: addressController.text.trim());

        final DateTime now = DateTime.now();

        OrderData requestEmployeeModel = OrderData(
          employeeName: employeeName,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          email: 'belalscg@gmmail.com',
          time: DateFormat('hh:mm a').format(now),
          compoundName: SharedPreferencesHelper.compoundName,
          service: 'Request employee',
          address: addressController.text,
          isRead: false,
          note: noteController.text,
          phoneNumber: phoneController.text,
          isPaid: 'un paid',
        );
        await requestEmployeeRepo.send_order_for_database(
            requestEmployeeModel: requestEmployeeModel);

        _isLoading = false;
        _isDoneOrder = true;
        notifyListeners();
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        connector!.onError(e.toString());
      }
    } else {
      connector!.onError("address and phone number must be not empty ");
    }
  }

  bool _checkFieldsNotNull({
    required TextEditingController phoneController,
    required TextEditingController addressController,
  }) {
    return phoneController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty;
  }
}
