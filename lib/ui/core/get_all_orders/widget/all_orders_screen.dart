import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/data/repositires/get_order/get_order.dart';
import 'package:qr_code/data/services/data_base/order/get_orders.dart';
import 'package:qr_code/ui/core/get_all_orders/connector/get_all_orders_connector.dart';
import 'package:qr_code/ui/core/get_all_orders/view_model/get_all_orders_view_model.dart';
import 'package:qr_code/ui/core/ui/error_widget.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../domain/models/order_data.dart';
import '../../../../utils/app_colors.dart';
import '../../ui/shared_widgets.dart';
import 'al_order_item.dart';

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
          leading: Icon(Icons.notifications_active, color: Colors.white),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a Date:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCalendar(),
                      Expanded(
                        child: StreamBuilder<List<OrderData>>(
                          stream: viewModel.ordersStream(date: selectedDate),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No orders available.'));
                            } else {
                              final orders = snapshot.data!;
                              return ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: AllOrdersItem(
                                        getOrderData: orders[index]),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ]))));
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: CalendarTimeline(
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 360)),
        lastDate: DateTime.now().add(const Duration(days: 360)),
        onDateSelected: (date) {
          selectedDate = date;
          setState(() {});
        },
        dotColor: Colors.white,
        dayColor: Colors.black26,
        activeDayColor: Colors.white,
        activeBackgroundDayColor: AppColors.primary,
        locale: 'en_ISO',
      ),
    );
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
    throw UnimplementedError();
  }
}
