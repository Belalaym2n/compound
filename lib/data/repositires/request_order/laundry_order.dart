import 'package:qr_code/domain/models/order_data.dart';

import '../../services/data_base/send_order_to_data_base.dart';

class LaundryRepo {
  SendOrderToDatabase sendOrderToDatabase;

  LaundryRepo(this.sendOrderToDatabase);

  Future<void> send_order_to_data_base({required OrderData laundryModel}) {
    return sendOrderToDatabase.sendToDatabase(laundryModel, 'Orders');
  }
}
