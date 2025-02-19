import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/data/repositires/notification/sendNotifcationRepo.dart';
import 'package:qr_code/data/repositires/request_order/best_controller_order_repo.dart';
import 'package:qr_code/data/services/data_base/send_order_to_data_base.dart';
import 'package:qr_code/data/services/notifcation/orderNotification.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/shared_widgets.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../../data/services/shared_pref_helper.dart';
import '../../../../../../utils/constants.dart';
import '../../../../ui/sharedWidgets/checkIneternet.dart';
import '../../../../ui/sharedWidgets/success_widget.dart';
import '../../checkoutOption/checkOutOption.dart';
import '../connector/best_controller_connector.dart';
import '../view_model/best_controller_view_model.dart';
import '../widget/step_one_content.dart';
import '../widget/step_two_widget.dart';
import '../widget/stepperButtonsWidget.dart';

class BestControllerItem extends StatefulWidget {
  const BestControllerItem({super.key});

  @override
  State<BestControllerItem> createState() => _BestControllerScreenState();
}

class _BestControllerScreenState
    extends BaseView<BestControllerViewModel, BestControllerItem>
    implements BestControllerConnector {
  TextEditingController noteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
    SharedPreferencesHelper.loadUserDataForOrders(
        areaController: areaController,
        phoneController: phoneController,
        addressController: addressController);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<BestControllerViewModel>(
            builder: (context, viewModel, child) => Scaffold(
                  backgroundColor: Colors.white,
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    title: servic_name(serviceName: "Best Controller"),
                    centerTitle: true,
                  ),
                  body: InternetWrapper(
                      child: SingleChildScrollView(
                          child: viewModel.orderIsDone == true
                              ? done_order_widget(context)
                              : Stepper(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  currentStep: viewModel.index,

                                  controlsBuilder: (context, details) {
                                    return stepperButtonsWidget(
                                        isLoading: viewModel.isLoading,
                                        isDone: viewModel.index == 2,
                                        index: viewModel.index,
                                        onStepCancel: viewModel.onStepCancel,
                                        onStepContinue: () =>
                                            viewModel.onStepContinue(
                                                areaController: areaController,
                                                addressController:
                                                    addressController,
                                                phoneNumberController:
                                                    phoneController,
                                                noteController:
                                                    noteController));
                                  },
                                  // onStepCancel: viewModel.onStepCancel,
                                  steps: viewModel.steps,
                                ))),
                )));
  }

  @override
  step_one_content({String? ruleName}) {
    return StepOneContent(
      changePrice: () => viewModel.changePrice,
      chooseProblem: () => viewModel.chooseProblem,
      problemSelected: viewModel.problem,
    );
  }

  @override
  step_two_content() {
    // TODO: implement step_two_content
    return step_two_widget(
        areaController: areaController,
        phoneController: phoneController,
        addressController: addressController,
        noteController: noteController);
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
  final_step_content() {
    // TODO: implement final_step_content
    return CheckOutOption(
      isLoading: viewModel.isLoading,
      price: viewModel.price,
      sumbmitToDataBase: () {
        viewModel.submit_to_database(
            noteController: noteController,
            phoneController: phoneController,
            addressController: addressController,
            areaController: areaController);
      },
    );
  }

  @override
  BestControllerViewModel init_my_view_model() {
    OrderNotificationService orderNotificationService =
        OrderNotificationService();

    SendNotificationRepo sendNotificationRepo =
        SendNotificationRepo(orderNotificationService);

    SendOrderToFirebaseDatabaseService sendOrderToDatabase =
        SendOrderToFirebaseDatabaseService();
    BestControllerOrderRepo bestControllerOrderRepo =
        BestControllerOrderRepo(sendOrderToDatabase);
    // TODO: implement init_my_view_model
    return BestControllerViewModel(
        bestControllerOrderRepo, sendNotificationRepo);
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
}
