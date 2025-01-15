import 'package:qr_code/data/repositires/request_order/laundry_order.dart';
import 'package:qr_code/data/services/data_base/send_order_to_data_base.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/services/shared_pref_helper.dart';
import '../../../../../domain/models/order_data.dart';

class LaundryViewModel extends BaseViewModel {
  final SendOrderToDatabase sendOrderToDatabase;
  final LaundryRepo laundryRepo;
  bool _isDone = false;
  bool _isLoading = false;

  bool get isDone => _isDone;

  bool get isLoading => _isLoading;

  LaundryViewModel(this.sendOrderToDatabase, this.laundryRepo);

  send_order_to_database({required OrderData laundryModel}) async {
    bool fieldsAreValid = _checkFieldsNotNull(
      phoneController: laundryModel.phoneNumber ?? '',
      addressController: laundryModel.address ?? '',
    );

    if (fieldsAreValid) {
      print("is loading $isLoading");
      _isLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 1)); // تأخير لمدة ثانية واحدة

      print("is loading $isLoading");
      await SharedPreferencesHelper.saveData(
          key: "phone", value: laundryModel.phoneNumber!.trim());

      await SharedPreferencesHelper.saveData(
          key: "address", value: laundryModel.address!.trim());

      await laundryRepo.send_order_to_data_base(laundryModel: laundryModel);
      print("is loading $isLoading");

      _isLoading = false;
      _isDone = true;
      notifyListeners();
    } else {
      _isLoading = false;
      notifyListeners();
      connector!.onError("address and phone number  must be not empty ");
    }
  }

  bool _checkFieldsNotNull({
    required String phoneController,
    required String addressController,
  }) {
    return phoneController.isNotEmpty && addressController.isNotEmpty;
  }
}
