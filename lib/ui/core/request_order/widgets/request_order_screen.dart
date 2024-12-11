import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/request_order/widgets/widgets.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

import '../../online_payment/payment_screen.dart';
import '../view_model/request_order_view_model.dart';
import 'connector.dart';

class RequestOrderScreen extends StatefulWidget {
  RequestOrderScreen({super.key, required this.serviceName});

  String serviceName;

  @override
  State<RequestOrderScreen> createState() => _RequestOrderScreenState();
}

class _RequestOrderScreenState extends State<RequestOrderScreen>
    implements RequestOrderConnector {
  RequestOrderViewModel viewModel = RequestOrderViewModel();

  bool isEditing = false;
  String selectedOption = 'cash';

  void selectOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  TextEditingController noteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<RequestOrderViewModel>(
        builder: (context, viewModel, child) => Scaffold(
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
            body: Stepper(
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

  buttons_widget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Constants.screenWidth * 0.03))),
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
                color: Colors.white, fontSize: Constants.screenWidth * 0.04),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
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
                color: Colors.white, fontSize: Constants.screenWidth * 0.03),
          ),
        ),
      ],
    );
  }

  @override
  errorMessage(String error) {
    // TODO: implement errorMessage
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18)),
        content: Text(error),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18)))
        ],
      ),
    );
  }

  Widget _buildPaymentOption({required String text, IconData? icon}) {
    return Material(
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
    );
  }

  @override
  final_step_content() {
    // TODO: implement final_step_content
    return Column(
      children: [
        _buildPaymentOption(text: 'Cash on employee', icon: Icons.payment),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentView(
                      onPaymentSuccess: () {},
                      price: 100,
                      onPaymentError: () {}),
                ));
          },
          child: _buildPaymentOption(text: "Pay with visa"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  step_one_content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        editableContainer(
            editingController: addressController, isEditing: false),
        SizedBox(height: Constants.screenHeight * 0.018),
        space_divider(),
        SizedBox(height: Constants.screenHeight * 0.018),
        text_form_field(
          controller: phoneController,
          label: "Phone",
          height: Constants.screenHeight * 0.06,
          icon: Icons.phone_callback_outlined,
        ),
        SizedBox(height: Constants.screenHeight * 0.019),
        text_form_field(
          controller: addressController,
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
  step_two_content() {
    // TODO: implement step_two_content
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
                        "50\$",
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
