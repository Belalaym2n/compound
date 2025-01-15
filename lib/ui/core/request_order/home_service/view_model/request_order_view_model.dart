import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/data/repositires/request_order/request_order_data_base_repo.dart';
import 'package:qr_code/utils/app_colors.dart';

import '../../../../../data/services/shared_pref_helper.dart';
import '../../../../../domain/models/order_data.dart';
import '../widgets/connector.dart';

class RequestOrderViewModel extends ChangeNotifier {
  HomeServiceOrderDatabaseRepo databaseRepo = HomeServiceOrderDatabaseRepo();
  late RequestOrderConnector connector;
  String _selectedRule = '';
  String _price = '';

  bool _isLoading = false;
  bool _orderIsDone = false;

  bool get orderIsDone => _orderIsDone;

  bool get isLoading => _isLoading;

  String get selectedRule => _selectedRule;

  String get price => _price;

  changePrice(String price) {
    _price = price;
    notifyListeners();
  }

  changeRule(String value) {
    _selectedRule = value;
    notifyListeners();
  }

  Future<void> submit_to_database({
    required TextEditingController noteController,
    required TextEditingController phoneController,
    required TextEditingController addressController,
    required String serviceName,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      print("belal");

      final DateTime now = DateTime.now();

      OrderData requestOrder = OrderData(
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          compoundName: SharedPreferencesHelper.compoundName,
          note: noteController.text.trim(),
          service: serviceName,
          area: selectedRule,
          address: addressController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          isPaid: "un paid",
          email: 'belalscg@gmail.com',
          time: DateFormat('hh:mm a').format(now)

          //   date: DateUtils.dateOnly(DateTime.now()).millisecondsSinceEpoch,
          );
      await databaseRepo.send_order_for_database(
        orderData: requestOrder,
      );

      _isLoading = false;
      _orderIsDone = true;
      notifyListeners();
    } catch (e) {
      connector.errorMessage(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners(); // تأكد أن الحالة تُحدث دائماً
    }

    // Simulate some work
  }

  // ApiNotification apiNotification = ApiNotification();
  bool isComplete = false;
  bool complete = true;
  int index = 0;

  onStepCancel() {
    if (index > 0) {
      index = index - 1;
      notifyListeners();
    }
  }

  void loadCachedData({
    required TextEditingController phoneController,
    required TextEditingController addressController,
  }) async {
    final phone = await SharedPreferencesHelper.getData("phone");
    final address = await SharedPreferencesHelper.getData("address");

    if (phone != null) phoneController.text = phone;
    if (address != null) addressController.text = address;

    print("Cached Data Loaded: Phone: $phone, Address: $address");
  }

  onStepContinue({
    required TextEditingController noteController,
    required TextEditingController phoneController,
    required TextEditingController addressController,
    required String externalID,
  }) async {
    if (selectedRule == '') {
      connector.errorMessage("please choose area");
    } else if (index == 0) {
      index += 1;
      print("index $index");
      notifyListeners();
    } else if (index == 1) {
      bool fieldsAreValid = _checkFieldsNotNull(
        phoneController: phoneController,
        addressController: addressController,
      );

      if (fieldsAreValid) {
        await SharedPreferencesHelper.saveData(
            key: "phone", value: phoneController.text.trim());
        await SharedPreferencesHelper.saveData(
            key: "address", value: addressController.text.trim());
        index += 1;
        notifyListeners();
        print("Index: $index");
      } else {
        connector.errorMessage("Phone and address must not be empty");
      }
    } else if (index == 1) {
      index += 1;
      notifyListeners();
    } else {
      index += 1;
      notifyListeners();
      print("object");
    }
  }

  bool _checkFieldsNotNull({
    required TextEditingController phoneController,
    required TextEditingController addressController,
  }) {
    return phoneController.text.isNotEmpty && addressController.text.isNotEmpty;
  }

  List<Step> get steps => [
        _buildStep(
          isActive: index > 0,
          title: 'Choose Area',
          isCurrentStep: index == 0,
          colorIndex: index > 0,
          content: connector.first_step(),
        ),
        _buildStep(
          isActive: index > 1,
          title: 'Contact information',
          isCurrentStep: index == 1,
          colorIndex: index > 1,
          content: connector.stepTwoContent(),
        ),
        _buildStep(
          isActive: index > 2,
          title: 'Request Order',
          isCurrentStep: index == 2,
          colorIndex: index > 2,
          content: connector.step_three_content(price: _price),
        ),
        _buildStep(
          isActive: index > 3,
          title: 'Checkout',
          isCurrentStep: index == 3,
          colorIndex: index > 3,
          content: connector.final_step_content(_isLoading),
        ),
      ];

  Step _buildStep({
    required bool colorIndex,
    required bool isActive,
    required String title,
    required Widget content,
    required bool isCurrentStep,
  }) {
    return Step(
      stepStyle: StepStyle(
        indexStyle: TextStyle(
          color: colorIndex ? Colors.white : AppColors.primary,
        ),
        color: AppColors.primary,
      ),
      isActive: isActive,
      title: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: TextStyle(
          fontSize: isCurrentStep ? 18 : 14,
          fontWeight: FontWeight.bold,
          color: isCurrentStep ? AppColors.primary : Colors.grey,
        ),
        child: connector.tittleName(title),
      ),
      content: Column(
        children: [content],
      ),
    );
  }

// send_notification_for_technical_support({
//   required String name,
//   required String phone,
//   required String address,
//   required String externalId,
// }) async {
//   Response response = await apiNotification.post_data(
//       externalId: externalId,
//       message: "name is :$name \n Address is :$address \n phone is :$phone");
//
//   try {
//     if (response.statusCode == 200) {
//       print('تم إرسال الإشعار بنجاح');
//     } else {
//       print('فشل إرسال الإشعار: ${response.body}');
//     }
//   } catch (e) {
//     print('خطأ في إرسال الإشعار: $e');
//   }
// }
}
