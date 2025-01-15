import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/success_widget.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../data/repositires/request_order/request_order_data_base_repo.dart';
import '../../../online_payment/payment_screen.dart';
import '../../../ui/sharedWidgets/text_form_field_in_order.dart';
import '../view_model/request_order_view_model.dart';
import 'connector.dart';

class RequestOrderScreen extends StatefulWidget {
  RequestOrderScreen({super.key, required this.serviceName});

  HomeServiceOrderDatabaseRepo databaseRepo = HomeServiceOrderDatabaseRepo();

  String serviceName;

  @override
  State<RequestOrderScreen> createState() => _RequestOrderScreenState();
}

class _RequestOrderScreenState extends State<RequestOrderScreen>
    implements RequestOrderConnector {
  RequestOrderViewModel viewModel = RequestOrderViewModel();

  bool isEditing = false;
  String selectedOption = 'cash';

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
          leading: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          ),
          toolbarHeight: 40,
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
                          return buttons_widget();
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
    return Column(
      children: [
        viewModel.isLoading == true
            ? Center(child: CircularProgressIndicator())
            : _buildPaymentOption(
                text: 'Cash on employee',
                icon: Icons.payment,
                cash: () async {
                  print("Before loading: ${viewModel.isLoading}");
                  await viewModel.submit_to_database(
                      serviceName: widget.serviceName,
                      noteController: noteController,
                      phoneController: phoneController,
                      addressController: addressController);
                  print("After loading: ${viewModel.isLoading}");
                }),
        SizedBox(
          height: 20,
        ),
        viewModel.isLoading == true
            ? SizedBox()
            : _buildPaymentOption(
                text: "Pay with visa",
                cash: () {
                  print("payment ${viewModel.price}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentView(
                            onPaymentSuccess: () {},
                            price: double.tryParse(viewModel.price) ?? 100,
                            onPaymentError: () {}),
                      ));
                }),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  buttons_widget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        viewModel.index == 3
            ? SizedBox()
            : ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Constants.screenWidth * 0.03))),
                    backgroundColor: WidgetStatePropertyAll(AppColors.primary)),
                onPressed: () => viewModel.onStepContinue(
                  externalID: 'service',
                  noteController: noteController,
                  phoneController: phoneController,
                  addressController: addressController,
                ),
                child: Text(
                  viewModel.index == 0
                      ? "Continue"
                      : viewModel.index == 1
                          ? "Continue"
                          : "Checkout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Constants.screenWidth * 0.04),
                ),
              ),
        const SizedBox(width: 8),
        viewModel.index == 3 && viewModel.isLoading == true
            ? Center(child: SizedBox())
            : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.screenWidth * 0.03))),
                ),
                onPressed: viewModel.onStepCancel,
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Constants.screenWidth * 0.03),
                ),
              ),
      ],
    );
  }

  @override
  errorMessage(String error) {
    // TODO: implement errorMessage
    return error_widget(context: context, message: error);
  }

  Widget _buildPaymentOption(
      {required String text, IconData? icon, required Function cash}) {
    return InkWell(
      onTap: () {
        cash();
      },
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
            border:
                Border.all(color: AppColors.primary.withOpacity(0.6), width: 2),
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon != null
                  ? Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.payment,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ],
                    )
                  : SvgPicture.asset(
                      "assets/images/visa.svg",
                      height: Constants.screenHeight * 0.04,
                      width: Constants.screenWidth * 0.04,
                    ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  stepTwoContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        text_form_field_in_order(
          controller: addressController,
          label: "Add Address",
          height: Constants.screenHeight * 0.14,
          icon: Icons.location_on,
        ),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.018),
        text_form_field_in_order(
          controller: phoneController,
          label: "Phone",
          height: Constants.screenHeight * 0.06,
          icon: Icons.phone_callback_outlined,
        ),
        SizedBox(height: Constants.screenHeight * 0.019),
        text_form_field_in_order(
          controller: noteController,
          label: "Add note",
          height: Constants.screenHeight * 0.1,
          icon: Icons.edit_note,
        ),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.018),
      ],
    );
  }

  space_divider() {
    return Divider(
      height: Constants.screenHeight * 0.005,
      color: Colors.blueGrey.withOpacity(0.5),
      thickness: 1.5,
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            area_widget(ruleName: '100 :150', price: "100"),
            Text("100\$")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            area_widget(ruleName: '150"200', price: "200"),
            Text("200\$")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            area_widget(ruleName: '200 :250', price: "300"),
            Text("300\$")
            // problem_name(
            //     onChanged: viewModel.changeRule,
            //     ruleName: '200 :250',
            //     price: "300", groupValue: viewModel.selectedRule),
          ],
        ),
      ],
    );
  }

  Widget area_widget({String? ruleName, required String price}) {
    return Row(
      children: [
        Radio<String>(
          value: ruleName ?? '',
          groupValue: viewModel.selectedRule,
          onChanged: (value) {
            viewModel.changeRule(value!);
            viewModel.changePrice(price);
            print(viewModel.selectedRule);
          },
          activeColor: AppColors.primary,
        ),
        Text(
          ruleName ?? "",
          style: TextStyle(color: AppColors.primary),
        ),
      ],
    );
  }

  @override
  step_three_content({required String price}) {
    return Column(
      children: [
        Material(
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.15),
          child: Container(
            width: Constants.screenWidth,
            height: Constants.screenHeight * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
              border: Border.all(
                  color: AppColors.primary.withOpacity(0.6), width: 2),
            ),
            child: Padding(
              padding: EdgeInsets.all(Constants.screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Details",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: Constants.screenWidth * 0.035)),
                  SizedBox(height: Constants.screenHeight * 0.015),
                  const Divider(height: 2, color: Colors.black54),
                  SizedBox(height: Constants.screenHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items Total Price",
                        style: TextStyle(
                            color: AppColors.lightBlack,
                            fontSize: Constants.screenWidth * 0.038,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        price,
                        style:
                            TextStyle(fontSize: Constants.screenWidth * 0.035),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Constants.screenHeight * 0.018,
        ),
      ],
    );
  }
}
