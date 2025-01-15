import 'package:qr_code/domain/models/order_data.dart';

import '../../services/data_base/send_order_to_data_base.dart';

class RequestEmployeeRepo {
  SendOrderToDatabase databaseService = SendOrderToDatabase();

  Future<void> send_order_for_database(
      {required OrderData requestEmployeeModel}) async {
    await databaseService.sendToDatabase(requestEmployeeModel, 'Orders');
  }
}
