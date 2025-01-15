import '../../../domain/models/order_data.dart';
import '../../services/data_base/order/get_orders.dart';

class GetAllOrderRepo {
  final DatabaseServiceGetAllOrders databaseServiceGetAllOrders;

  GetAllOrderRepo(this.databaseServiceGetAllOrders);

  Stream<List<OrderData>> fetchOrdersStream({
    required DateTime dateTime,
  }) {
    return databaseServiceGetAllOrders.getAllOrdersStream(dateTime: dateTime);
  }
}
