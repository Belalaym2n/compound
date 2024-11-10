import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/screensForUser/online_payment/payment_screen.dart';
import 'package:qr_code/screens/screensForUser/request_order/connector.dart';
import 'package:qr_code/screens/screensForUser/request_order/request_order_view_model.dart';

import '../../../utils/widgets.dart';

class RequestOrderScreen extends StatefulWidget {
  RequestOrderScreen({super.key, required this.serviceName});

  String serviceName;

  @override
  State<RequestOrderScreen> createState() => _RequestOrderScreenState();
}

class _RequestOrderScreenState extends State<RequestOrderScreen>
    implements RequestOrderConnector {
  RequestOrderViewModel viewModel = RequestOrderViewModel();

  @override
  void initState() {
    viewModel.connector = this;
    super.initState();

    // TODO: implement initState
  }

  double screenHeight = 0;

  double screenWidth = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<RequestOrderViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  widget.serviceName,
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
              ),
              body: viewModel.isComplete
                  ? success_order()
                  : Stepper(
                      currentStep: viewModel.index,

                      controlsBuilder: (context, details) {
                        return buttons_widget();
                      },
                      // onStepCancel: viewModel.onStepCancel,
                      steps: viewModel.steps,
                    ));
        },
      ),
    );
  }

  @override
  Widget step_one_content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTitle("Name", screenWidth),
        SizedBox(
          height: screenHeight / 70,
        ),
        customFormField(
            hintText: "Enter your name",
            iconData: Icons.person,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            controller: nameController,
            obscureText: false),
        SizedBox(
          height: screenHeight / 50,
        ),
        customTitle("phone", screenWidth),
        SizedBox(
          height: screenHeight / 70,
        ),
        customFormField(
            hintText: "Enter your phone",
            iconData: Icons.phone,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            controller: phoneController,
            obscureText: false),
        SizedBox(
          height: screenHeight / 50,
        ),
        customTitle("Address", screenWidth),
        SizedBox(
          height: screenHeight / 70,
        ),
        customFormField(
            hintText: "Enter your address",
            iconData: Icons.location_on,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            controller: addressController,
            obscureText: false),
        SizedBox(
          height: screenHeight / 50,
        ),
        //
        // Add more widgets as needed
      ],
    );
  }

  buttons_widget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03))),
              backgroundColor: const WidgetStatePropertyAll(Colors.green)),
          onPressed: () => viewModel.onStepContinue(
            externalID: 'service',
            nameController: nameController,
            phoneController: phoneController,
            addressController: addressController,
          ),
          child: Text(
            viewModel.index == 0
                ? "Continue"
                : viewModel.index == 1
                    ? "Request Order"
                    : "Confirmation Order",
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03))),
          ),
          onPressed: viewModel.onStepCancel,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.03),
          ),
        ),
      ],
    );
  }

  @override
  Text tittleName(String tittle) {
    return Text(tittle,
        style: TextStyle(
            fontSize: screenWidth * 0.04, fontWeight: FontWeight.w600));
  }

  Widget success_order() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: screenHeight * 0.2,
        ),
        Center(
          child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 3,
              child: LottieBuilder.asset(
                "assets/json_animation/animation.json",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
              )),
        ),
        Text(
          "Order Success",
          style: TextStyle(color: Colors.green, fontSize: screenWidth * 0.07),
        ),
      ],
    );
  }

  @override
  Future errorMessage(String error) {
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

  @override
  final_step_content() {
    // TODO: implement final_step_content
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "اختر طريقة الدفع",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Card for cash payment
            GestureDetector(
              onTap: () {
                // Add logic for cash payment selection
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.orangeAccent,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.money,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "كاش",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Card for Visa payment
            GestureDetector(
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
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.blueAccent,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "فيزا",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
