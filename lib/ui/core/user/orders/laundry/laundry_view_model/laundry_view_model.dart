import 'package:qr_code/data/repositires/request_order/laundry_order.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../../data/services/shared_pref_helper.dart';
import '../../../../../../domain/models/order_data.dart';

class LaundryViewModel extends BaseViewModel {
  final LaundryRepo laundryRepo;
  bool _isDone = false;
  bool _isLoading = false;

  bool get isDone => _isDone;

  bool get isLoading => _isLoading;

  LaundryViewModel(this.laundryRepo);

  send_order_to_database({required OrderData laundryModel}) async {
    bool fieldsAreValid = _checkFieldsNotNull(
      phoneController: laundryModel.phoneNumber ?? '',
      addressController: laundryModel.address ?? '',
    );
    try {
      if (fieldsAreValid) {
        setLoading(true);
        await Future.delayed(
            const Duration(seconds: 1)); // تأخير لمدة ثانية واحدة

        await SharedPreferencesHelper.saveData(
            key: "phone", value: laundryModel.phoneNumber!.trim());

        await SharedPreferencesHelper.saveData(
            key: "address", value: laundryModel.address!.trim());

        await laundryRepo.send_order_to_data_base(laundryModel: laundryModel);

        _isLoading = false;
        _isDone = true;
        notifyListeners();
      } else {
        setLoading(false);
        connector!.onError("address and phone number  must be not empty ");
      }
    } catch (e) {
      connector!.onError("message");
    }
  }

  setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool _checkFieldsNotNull({
    required String phoneController,
    required String addressController,
  }) {
    return phoneController.trim().isNotEmpty &&
        addressController.trim().isNotEmpty;
  }
}
