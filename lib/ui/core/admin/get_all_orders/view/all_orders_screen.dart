import 'package:flutter/material.dart';
import 'package:qr_code/data/repositires/get_order/get_order.dart';
import 'package:qr_code/data/services/data_base/order/get_orders.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/utils/base.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../utils/app_colors.dart';
import '../../../ui/sharedWidgets/calender.dart';
import '../../../ui/sharedWidgets/shared_widgets.dart';
import '../connector/get_all_orders_connector.dart';
import '../view_model/get_all_orders_view_model.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState
    extends BaseView<GetAllOrdersViewModel, AllOrdersScreen>
    implements GetAllOrderConnector {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              servic_name(serviceName: "All Orders", textColor: Colors.white),
          elevation: 4,
          backgroundColor: AppColors.primary,
          leading: const Icon(Icons.notifications_active, color: Colors.white),
        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.screenWidth * 0.04,
                    vertical: Constants.screenHeight * 0.015),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a Date:',
                        style: TextStyle(
                          fontSize: Constants.screenWidth * 0.042,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: Constants.screenHeight * 0.017),
                      CalendarWidget(
                        initialDate: selectedDate,
                        onDateChanged: (newDate) {
                          setState(() {
                            selectedDate = newDate;
                          });
                        },
                      ),
                      Expanded(child: viewModel.showOrder(date: selectedDate)),
                    ]))));
  }

  @override
  GetAllOrdersViewModel init_my_view_model() {
    DatabaseServiceGetAllOrders databaseServiceGetAllOrders =
        DatabaseServiceGetAllOrders();

    GetAllOrderRepo getAllOrderRepo =
        GetAllOrderRepo(databaseServiceGetAllOrders);

    // TODO: implement init_my_view_model
    return GetAllOrdersViewModel(getAllOrderRepo);
  }

  @override
  onError(String message) {
    // TODO: implement onError
    return error_widget(context: context, message: message);
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    return const Center(child: CircularProgressIndicator());
  }
}
