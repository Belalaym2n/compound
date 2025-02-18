import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../../data/repositires/request_order/booking_order_car_wash_repo.dart';
import '../../../../../../data/services/data_base/booking/upload_booking_service.dart';
import '../../../../../../domain/models/booking_model.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../ui/sharedWidgets/calender.dart';
import '../../../../ui/sharedWidgets/shared_widgets.dart';
import '../connector/get_cat_wash_booking_connector.dart';
import '../view_model/get_booking_view_model.dart';
import 'get_car_wash_bookin_item.dart';

class GetCarWashBookingScreen extends StatefulWidget {
  const GetCarWashBookingScreen({super.key});

  @override
  State<GetCarWashBookingScreen> createState() => _GetCarWashBookingScreen();
}

class _GetCarWashBookingScreen
    extends BaseView<GetCarWashBookingViewModel, GetCarWashBookingScreen>
    implements GetCatWashBookingConnector {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: servic_name(
              serviceName: "Car Wash Booking", textColor: Colors.white),
          elevation: 4,
          backgroundColor: AppColors.primary,
          leading: Icon(Icons.request_quote_rounded, color: Colors.white),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a Date:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CalendarWidget(
                        initialDate: selectedDate,
                        onDateChanged: (newDate) {
                          setState(() {
                            selectedDate = newDate;
                          });
                          print('Selected Date: $selectedDate');
                        },
                      ),
                      Expanded(
                        child: StreamBuilder<List<Booking>>(
                          stream: viewModel.get_booking(date: selectedDate),
                          // استخدم التاريخ الصحيح
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              print("error: ${snapshot.error}");
                              return Center(child: Text("An error occurred."));
                            }

                            final bookings = snapshot.data;

                            if (bookings == null || bookings.isEmpty) {
                              return Center(child: Text('No bookings found.'));
                            }

                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(selectedDate);

                            return ListView.builder(
                              itemCount: bookings.length,
                              itemBuilder: (context, index) {
                                final booking = bookings[index];

                                // البحث عن رقم الفهرس للتاريخ المحدد
                                int bookingIndex =
                                    booking.selectedDates.indexWhere(
                                  (date) => date.date == formattedDate,
                                );

                                // ملاحظة: تجنب استدعاء دوال تغير الحالة هنا
                                return GetCarWashBookingItem(
                                  // تأكد من أن الدالة لا تقوم بتغيير حالة الواجهة أثناء البناء
                                  makeOrderDone: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      viewModel.update_order(
                                        id: booking.id.toString(),
                                        date: selectedDate,
                                      );
                                    });
                                  },
                                  isDone: booking
                                      .selectedDates[bookingIndex].isDone,
                                  bookingModel: booking,
                                );
                              },
                            );
                          },
                        ),
                      )
                    ]))));
  }

  @override
  GetCarWashBookingViewModel init_my_view_model() {
    UploadBookingDatabaseService uploadBookingDatabaseService =
        UploadBookingDatabaseService();
    CarWashBookingRepo carWashBookingRepo =
        CarWashBookingRepo(uploadBookingDatabaseService);
    // TODO: implement init_my_view_model
    return GetCarWashBookingViewModel(carWashBookingRepo);
  }

  @override
  onError(String message) {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    throw UnimplementedError();
  }
}
