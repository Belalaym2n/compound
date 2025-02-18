import 'package:qr_code/utils/base.dart';

import '../../../../../../data/repositires/request_order/booking_order_car_wash_repo.dart';
import '../../../../../../domain/models/booking_model.dart';
import '../connector/get_cat_wash_booking_connector.dart';

class GetCarWashBookingViewModel
    extends BaseViewModel<GetCatWashBookingConnector> {
  CarWashBookingRepo carWashBookingRepo;

  GetCarWashBookingViewModel(this.carWashBookingRepo);

  Stream<List<Booking>>? get_booking({required DateTime date}) {
    try {
      return carWashBookingRepo.get_order(
          date: date); // Forward the date to the repository
    } catch (e) {
      connector!.onError(e.toString());
      rethrow;
    }
  }

  update_order({
    required String id,
    required DateTime date,
  }) {
    carWashBookingRepo.update_order(id: id, date: date);
  }
}
