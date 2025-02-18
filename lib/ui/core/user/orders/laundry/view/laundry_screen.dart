import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/data/repositires/request_order/laundry_order.dart';
import 'package:qr_code/data/services/data_base/send_order_to_data_base.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../../data/services/shared_pref_helper.dart';
import '../../../../../../domain/models/order_data.dart';
import '../../../../ui/sharedWidgets/success_widget.dart';
import '../laundry_view_model/laundry_view_model.dart';
import '../widgets/laundry_item.dart';

class LaundryScreen extends StatefulWidget {
  const LaundryScreen({super.key});

  @override
  State<LaundryScreen> createState() => _LaundryScreenState();
}

class _LaundryScreenState extends BaseView<LaundryViewModel, LaundryScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
    SharedPreferencesHelper.loadUserDataForOrders(
        phoneController: phoneController, addressController: addressController);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<LaundryViewModel>(
        builder: (context, viewModel, child) => viewModel.isDone == true
            ? Scaffold(body: done_order_widget(context))
            : LaundryItem(
                isLoading: viewModel.isLoading,
                requestEmployee: () {
                  OrderData laundryModel = OrderData(
                      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      compoundName:
                          SharedPreferencesHelper.compoundName ?? 'not exist',
                      email: SharedPreferencesHelper.email,
                      service: 'Laundry',
                      address: addressController.text,
                      note: noteController.text,
                      phoneNumber: phoneController.text,
                      time: DateFormat('HH:mm').format(DateTime.now()),
                      isPaid: 'un paid');
                  viewModel.send_order_to_database(laundryModel: laundryModel);
                },
                addressController: addressController,
                noteController: noteController,
                phoneController: phoneController,
              ),
      ),
    );
  }

  @override
  LaundryViewModel init_my_view_model() {
    SendOrderToFirebaseDatabaseService sendOrderToDatabase =
        SendOrderToFirebaseDatabaseService();
    LaundryRepo laundryRepo = LaundryRepo(sendOrderToDatabase);
    // TODO: implement init_my_view_model
    return LaundryViewModel(laundryRepo);
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
