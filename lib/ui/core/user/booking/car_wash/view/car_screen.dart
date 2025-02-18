import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/data/repositires/request_order/booking_order_car_wash_repo.dart';
import 'package:qr_code/data/services/data_base/booking/upload_booking_service.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/utils/base.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../../data/services/shared_pref_helper.dart';
import '../../../../../../utils/constants.dart';
import '../../../../ui/sharedWidgets/shared_widgets.dart';
import '../connector/car_wash_connector.dart';
import '../view_model/car_wash_view_model.dart';
import '../widget/download_booking/download_booking.dart';
import '../widget/elevated_button_stepper_car_wash/elevated_button_stepper_car_wash.dart';
import '../widget/steps_content/final_step_checkout.dart';
import '../widget/steps_content/step_one.dart';
import '../widget/steps_content/step_three_content.dart';
import '../widget/steps_content/step_two_content.dart';

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
    SharedPreferencesHelper.loadUserDataForOrders(
      nameController: nameController,
      phoneController: phoneController,
    );
  }

  final ScreenshotController screenshotController = ScreenshotController();

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
                        ? BookingDaysDonwload(
                            screenshotController: screenshotController,
                            saveImage: () {
                              viewModel.saveImage(
                                  screenshotController: screenshotController,
                                  context: context);
                            },
                            phoneNumber: phoneController.text,
                            name: nameController.text,
                            selectDates: viewModel.selectedDates,
                          )
                        : Stepper(
                            controlsBuilder: (context, details) {
                              return ElevatedButtonStepperCarWash(
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
    return FinalStepCheckoutCarWash(
      price: viewModel.price,
      isLoading: viewModel.isLoading,
      submitToDataBase: () {
        print(viewModel.price);
        viewModel.uploadBooking(
            context: context,
            name: nameController.text,
            phoneNumber: phoneController.text);
      },
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
    return StepOne(
        changePrice: viewModel.changePrice,
        selectBookingType: viewModel.selectBookingType,
        bookingType: viewModel.bookingType ?? "");
  }

  @override
  step_two_content() {
    // TODO: implement step_two_content
    return StepTwoContent(
      isSelected: viewModel.isSelected,
      toggleDateSelection: viewModel.toggleDateSelection,
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
    return StepThreeContent(
        phoneController: phoneController, nameController: nameController);
  }

  @override
  success_widget() {
    // TODO: implement success_widget
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "save image successufly",
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color(0xFF4CAF50), // Green for success
    ));
  }
}
