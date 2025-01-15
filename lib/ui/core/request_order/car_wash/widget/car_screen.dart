import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/data/repositires/request_order/booking_order_car_wash_repo.dart';
import 'package:qr_code/data/services/data_base/booking/upload_booking_service.dart';
import 'package:qr_code/ui/core/request_order/best_controller/widget/step_two_widget.dart';
import 'package:qr_code/ui/core/request_order/car_wash/connector/car_wash_connector.dart';
import 'package:qr_code/ui/core/request_order/car_wash/view_model/car_wash_view_model.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/base.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../utils/constants.dart';
import '../../../online_payment/payment_screen.dart';
import '../../../ui/sharedWidgets/check_out_widget.dart';
import '../../../ui/sharedWidgets/text_form_field_in_order.dart';
import '../../../ui/shared_widgets.dart';
import 'car_wash_item.dart';
import 'download_booking.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends BaseView<CarWashViewModel, CarScreen>
    implements CarWashConnector {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Scaffold(
            appBar: AppBar(
              title: servic_name(serviceName: "Car Wash"),
              centerTitle: true,
            ),
            body: Consumer<CarWashViewModel>(
                builder: (context, value, child) =>
                    viewModel.orderIsDone == true
                        ? DayListScreen()
                        : Stepper(
                            controlsBuilder: (context, details) {
                              return elevated_button_in_car_wash(
                                  isLoading: viewModel.isLoading,
                                  isDone: viewModel.index == 2,
                                  index: viewModel.index,
                                  onStepCancel: viewModel.onStepCancel,
                                  onStepContinue: () =>
                                      viewModel.onStepContinue(
                                          nameController: nameController,
                                          phoneController: phoneController,
                                          context: context));
                            },
                            steps: viewModel.steps,
                            currentStep: viewModel.index,
                          ))));
  }

  @override
  final_step_content() {
    // TODO: implement final_step_content
    return viewModel.isLoading
        ? Column(
            children: [
              SizedBox(
                height: Constants.screenHeight * 0.05,
              ),
              CircularProgressIndicator(
                color: AppColors.primary,
              ),
              SizedBox(
                height: Constants.screenHeight * 0.05,
              ),
            ],
          )
        : Column(
            children: [
              buildPaymentOption(
                  checkOut: () {
                    viewModel.uploadSelectedDates(context);
                  },
                  text: 'Cash on employee',
                  icon: Icons.payment),
              SizedBox(
                height: 20,
              ),
              buildPaymentOption(
                  text: "Pay with visa",
                  checkOut: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentView(
                              onPaymentSuccess: () {},
                              price: 100,
                              onPaymentError: () {}),
                        ));
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          );
  }

  @override
  CarWashViewModel init_my_view_model() {
    UploadBookingDatabaseService uploadBookingDatabaseService =
        UploadBookingDatabaseService();

    CarWashBookingRepo carWashBookingRepo =
        CarWashBookingRepo(uploadBookingDatabaseService);

    // TODO: implement init_my_view_model
    return CarWashViewModel(carWashBookingRepo);
  }

  @override
  onError(String message) {
    // TODO: implement onError
    return error_widget(context: context, message: message);
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    throw UnimplementedError();
  }

  @override
  step_one_content() {
    // TODO: implement step_one_content
    return Column(
      children: [
        ListTile(
          title: Text('Book a Day'),
          leading: Radio<String>(
            activeColor: AppColors.primary,
            value: 'day',
            groupValue: viewModel.bookingType,
            onChanged: (value) => viewModel.selectBookingType(value!),
          ),
        ),
        ListTile(
          title: Text('Book a Month'),
          leading: Radio<String>(
            activeColor: AppColors.primary,
            value: 'month',
            groupValue: viewModel.bookingType,
            onChanged: (value) => viewModel.selectBookingType(value!),
          ),
        ),
      ],
    );
  }

  @override
  step_two_content() {
    // TODO: implement step_two_content
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2040, 12, 31),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (day) => viewModel.isSelected(day),
      onDaySelected: (selectedDay, focusedDay) {
        viewModel.toggleDateSelection(selectedDay);
        print(selectedDay);
      },
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Text tittleName(String tittle) {
    // TODO: implement tittleName
    return Text(
      tittle,
      style: TextStyle(
        fontSize: Constants.screenWidth * 0.04,
        fontWeight: FontWeight.w600,
        color: Colors.black, // لون من الألوان الأساسية المريحة
      ),
    );
  }

  @override
  step_three_content() {
    // TODO: implement step_three_content
    return Column(
      children: [
        SizedBox(
          height: Constants.screenHeight * 0.01,
        ),
        text_form_field_in_order(
          controller: nameController,
          label: "Enter you name",
          height: Constants.screenHeight * 0.075,
          icon: Icons.phone_callback_outlined,
        ),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.01),
        text_form_field_in_order(
          controller: phoneController,
          label: "Enter Phone Number",
          height: Constants.screenHeight * 0.075,
          icon: Icons.phone_callback_outlined,
        ),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.018),
      ],
    );
  }
}
