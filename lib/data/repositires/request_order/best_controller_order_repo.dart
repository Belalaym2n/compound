import 'package:qr_code/domain/models/order_data.dart';

import '../../services/data_base/send_order_to_data_base.dart';

class BestControllerOrderRepo {
  SendOrderToFirebaseDatabaseService databaseService;

  BestControllerOrderRepo(this.databaseService);

  Future<void> send_order_for_database(
      {required OrderData bestControllerOrder}) async {
    await databaseService.sendToDatabase(bestControllerOrder, "Orders");
  }
}
