import 'package:dio/dio.dart';
import 'package:qr_code/utils/constants.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
        baseUrl: Constants.base_url,
        headers: {
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true),
  );

  static Future<Response> postData(
      {required String endPoint, Map<String, dynamic>? data}) async {
    return await dio.post(endPoint, data: data);
  }
}
