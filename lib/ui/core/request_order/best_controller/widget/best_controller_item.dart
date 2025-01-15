import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/data/repositires/request_order/best_controller_order_repo.dart';
import 'package:qr_code/ui/core/request_order/best_controller/connector/best_controller_connector.dart';
import 'package:qr_code/ui/core/request_order/best_controller/view_model/best_controller_view_model.dart';
import 'package:qr_code/ui/core/request_order/best_controller/widget/step_two_widget.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';
import 'package:qr_code/ui/core/ui/shared_widgets.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../data/services/shared_pref_helper.dart';
import '../../../../../utils/constants.dart';
import '../../../online_payment/payment_screen.dart';
import '../../../ui/sharedWidgets/check_out_widget.dart';
import '../../../ui/sharedWidgets/choose.dart';
import '../../../ui/sharedWidgets/elevated_button_stepper.dart';
import '../../../ui/sharedWidgets/success_widget.dart';

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
    SharedPreferencesHelper.loadCachedPhone_and_address(
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
            appBar: AppBar(
              title: servic_name(serviceName: "Best Controller"),
              centerTitle: true,
            ),
            body: viewModel.orderIsDone == true
                ? done_order_widget(context)
                : Stepper(
                    currentStep: viewModel.index,

                    controlsBuilder: (context, details) {
                      return buttonsWidget(
                          isLoading: viewModel.isLoading,
                          isDone: viewModel.index == 2,
                          index: viewModel.index,
                          onStepCancel: viewModel.onStepCancel,
                          onStepContinue: () => viewModel.onStepContinue(
                              areaController: areaController,
                              addressController: addressController,
                              phoneNumberController: phoneController,
                              noteController: noteController));
                    },
                    // onStepCancel: viewModel.onStepCancel,
                    steps: viewModel.steps,
                  )),
      ),
    );
  }

  @override
  step_one_content({String? ruleName}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            choose_widget(
              onChanged: viewModel.chooseProblem,
              ruleName: '7shrat',
              groupValue: viewModel.problem,
            ),
            Text("100\$")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            choose_widget(
              onChanged: viewModel.chooseProblem,
              ruleName: '7aga tanya',
              groupValue: viewModel.problem,
            ),
            Text("200\$")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            choose_widget(
              onChanged: viewModel.chooseProblem,
              ruleName: '7aga tanya and 7shrat',
              groupValue: viewModel.problem,
            ),
            Text("300\$")
          ],
        ),
      ],
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
    return viewModel.isLoading == true
        ? Column(
            children: [
              SizedBox(
                height: Constants.screenHeight * 0.05,
              ),
              CircularProgressIndicator()
            ],
          )
        : Column(
            children: [
              buildPaymentOption(
                  checkOut: () {
                    viewModel.submit_to_database(
                        noteController: noteController,
                        phoneController: phoneController,
                        addressController: addressController,
                        areaController: areaController);
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
  BestControllerViewModel init_my_view_model() {
    BestControllerOrderRepo bestControllerOrderRepo = BestControllerOrderRepo();
    // TODO: implement init_my_view_model
    return BestControllerViewModel(bestControllerOrderRepo);
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
