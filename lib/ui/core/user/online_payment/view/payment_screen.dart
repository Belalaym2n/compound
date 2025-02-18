import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/user/online_payment/view_model/payment_view_model.dart';
import 'package:qr_code/ui/core/user/online_payment/widgets/visa_screen.dart';

import '../../../../../domain/models/payment_data.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    super.key,
    required this.onPaymentSuccess,
    required this.price,
    required this.onPaymentError,
  });

  final VoidCallback onPaymentSuccess;
  final double price;
  final VoidCallback onPaymentError;

  @override
  PaymentViewState createState() => PaymentViewState();
}

class PaymentViewState extends State<PaymentView> {
  final PaymentData paymentData = PaymentData();

  bool isPaymentRequestLoading = false;
  PaymentViewModel viewModel = PaymentViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getAuthToken(); // جلب رمز التوثيق عند بدء التشغيل
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: Consumer<PaymentViewModel>(
        builder: (BuildContext context, viewModel, Widget? child) => Scaffold(
            appBar: AppBar(
              title: const Text('Pay with Visa'),
            ),
            body: viewModel.isAuthLoading ||
                    viewModel.isOrderLoading ||
                    viewModel.isPaymentRequestLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await viewModel
                            .getOrderRegistrationId(widget.price)
                            .then((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisaScreen(
                                onError: widget.onPaymentError,
                                onFinished: widget.onPaymentSuccess,
                                finalToken: viewModel.finalToken,
                                iframeId: paymentData.iframeId,
                              ),
                            ),
                          );
                        });
                      },
                      child: const Text('Confirm Payment',
                          style: TextStyle(fontSize: 18)),
                    ),
                  )),
      ),
    );
  }

  ButtonStyle _defaultButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
