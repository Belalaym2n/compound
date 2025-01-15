import 'package:qr_code/utils/base.dart';

import '../../../../data/repositires/get_order/get_order.dart';
import '../../../../domain/models/order_data.dart';
import '../connector/get_all_orders_connector.dart';

class GetAllOrdersViewModel extends BaseViewModel<GetAllOrderConnector> {
  final GetAllOrderRepo getAllOrderRepo;

  GetAllOrdersViewModel(this.getAllOrderRepo);

  Stream<List<OrderData>> ordersStream({required DateTime date}) {
    return getAllOrderRepo.fetchOrdersStream(dateTime: date);
  }
}
