import 'package:flutter/cupertino.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../models/payment_data.dart';
import 'dio.dart';

class PaymentViewModel extends ChangeNotifier {
  bool _isAuthLoading = false;
  bool _isOrderLoading = false;
  bool _isPaymentRequestLoading = false;

  String _paymentFirstToken = '';
  String _paymentOrderId = '';
  String _finalToken = '';

  bool get isAuthLoading => _isAuthLoading;

  bool get isOrderLoading => _isOrderLoading;

  bool get isPaymentRequestLoading => _isPaymentRequestLoading;

  String get paymentFirstToken => _paymentFirstToken;

  String get paymentOrderId => _paymentOrderId;

  String get finalToken => _finalToken;
  final PaymentData paymentData = PaymentData();

  Future<void> getAuthToken() async {
    _isAuthLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.postData(
        endPoint: Constants.auth_taken_enpoint,
        data: {"api_key": paymentData.apiKey},
      );
      _paymentFirstToken = response.data['token'];
      print("taken $_paymentFirstToken");
      notifyListeners();
    } catch (error) {
      print("error $error");
    } finally {
      _isAuthLoading = false;
      notifyListeners();
    }
  }

  Future<void> getOrderRegistrationId(double price) async {
    _isOrderLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.postData(
        endPoint: Constants.order_id_enpoint,
        data: {
          "auth_token": paymentFirstToken,
          "delivery_needed": "false",
          "amount_cents": (price * 100).toString(),
          "currency": "EGP",
          "items": [],
        },
      );
      _paymentOrderId = response.data['id'].toString();
      print("order id is  $paymentOrderId");

      await getPaymentRequest(price);
    } catch (error) {
      print("error order   $error");
    } finally {
      _isOrderLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPaymentRequest(double price) async {
    _isPaymentRequestLoading = true;
    notifyListeners();
    final requestData = {
      "auth_token": paymentFirstToken,
      "amount_cents": (price * 100).toString(),
      "expiration": 3600,
      "order_id": paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": 'NA',
        "floor": "NA",
        "first_name": 'NA',
        "street": "NA",
        "building": "NA",
        "phone_number": 'NA',
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": 'NA',
        "state": "NA",
      },
      "currency": "EGP",
      "integration_id": paymentData.integrationCardId,
      "lock_order_when_paid": "false",
    };

    try {
      final response = await DioHelper.postData(
        endPoint: '/acceptance/payment_keys',
        data: requestData,
      );
      print("response $response");
      _finalToken = response.data['token'];
    } catch (error) {
      print("error  request $error");
    } finally {
      _isPaymentRequestLoading = false;
      notifyListeners();
    }
  }
}
