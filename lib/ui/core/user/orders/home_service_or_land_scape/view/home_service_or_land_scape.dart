import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/success_widget.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../../data/repositires/request_order/request_order_data_base_repo.dart';
import '../../checkoutOption/checkOutOption.dart';
import '../connector/connector.dart';
import '../view_model/request_order_view_model.dart';
import '../widgets/button_widget_in_stepper.dart';
import '../widgets/home_service_or_land__scape_step_three_content.dart';
import '../widgets/home_service_or_land_scape_step_one_content.dart';
import '../widgets/home_service_or_land_scape_step_two_content.dart';

class HomeServiceOrLandScape extends StatefulWidget {
  HomeServiceOrLandScape({super.key, required this.serviceName});

  HomeServiceOrderDatabaseRepo databaseRepo = HomeServiceOrderDatabaseRepo();

  String serviceName;

  @override
  State<HomeServiceOrLandScape> createState() => _RequestOrderScreenState();
}

class _RequestOrderScreenState extends State<HomeServiceOrLandScape>
    implements RequestOrderConnector {
  RequestOrderViewModel viewModel = RequestOrderViewModel();

  bool isEditing = false;

  TextEditingController noteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewModel.connector = this;
    viewModel.loadCachedData(
        phoneController: phoneController, addressController: addressController);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primary,
            ),
          ),
          toolbarHeight: Constants.screenHeight * 0.046,
          backgroundColor: Colors.white,
          title: Text("Place Order",
              style: TextStyle(
                  fontSize: Constants.screenWidth * 0.05,
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<RequestOrderViewModel>(
            builder: (context, viewModel, child) =>
                viewModel.orderIsDone == true
                    ? done_order_widget(context)
                    : Stepper(
                        currentStep: viewModel.index,
                        controlsBuilder: (context, details) {
                          return ButtonWidgetInStepper(
                              isLoading: viewModel.isLoading,
                              onStepContinue: () => viewModel.onStepContinue(
                                    noteController: noteController,
                                    phoneController: phoneController,
                                    addressController: addressController,
                                  ),
                              index: viewModel.index,
                              onStepCancel: () => viewModel.onStepCancel);
                        },
                        // onStepCancel: viewModel.onStepCancel,
                        steps: viewModel.steps,
                      )),
      ),
    );
  }

  @override
  final_step_content(bool isLoading) {
    // TODO: implement final_step_content
    return CheckOutOption(
        sumbmitToDataBase: () {
          viewModel.submit_to_database(
              serviceName: widget.serviceName,
              noteController: noteController,
              phoneController: phoneController,
              addressController: addressController);
        },
        price: viewModel.price,
        isLoading: viewModel.isLoading);
  }

  @override
  errorMessage(String error) {
    // TODO: implement errorMessage
    return error_widget(context: context, message: error);
  }

  @override
  stepTwoContent() {
    return HomeServiceOrLandScapeStepTwoContent(
      phoneController: phoneController,
      noteController: noteController,
      addressController: addressController,
    );
  }

  @override
  Text tittleName(String tittle) {
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
  first_step({String? ruleName}) {
    return HomeServiceOrLandScapeStepOneContent(
      changePrice: viewModel.changePrice,
      changeRule: viewModel.changeRule,
      ruleSelected: viewModel.selectedRule,
    );
  }

  @override
  step_three_content({required String price}) {
    return HomeServiceOrLandScapeStepThreeContent(
      price: price,
    );
  }
}
