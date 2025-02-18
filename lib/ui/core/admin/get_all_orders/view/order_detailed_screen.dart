import 'package:flutter/material.dart';
import 'package:qr_code/domain/models/order_data.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

class OrderDetailedScreen extends StatelessWidget {
  final OrderData? orderData;
  VoidCallback makeOrderDone;

  OrderDetailedScreen({
    required this.orderData,
    required this.makeOrderDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF002B5B), // Navy Blue
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (orderData?.compoundName != null)
                  _buildInfoSection('Compound Name', orderData!.compoundName!),
                if (orderData?.service != null)
                  _buildInfoSection('Service Name', orderData!.service!),
                if (orderData?.problem != null)
                  _buildInfoSection('problem', orderData!.problem!),
                if (orderData?.area != null && orderData!.area!.isNotEmpty)
                  _buildInfoSection('Area', orderData!.area!),
                if (orderData?.employeeName != null)
                  _buildInfoSection('Employee', orderData!.employeeName!),
                if (orderData?.note != null || orderData!.note!.isNotEmpty)
                  _buildInfoSection('Note', orderData!.note!),
                if (orderData?.address != null)
                  _buildInfoSection('User Address', orderData!.address!),
                if (orderData?.email != null)
                  _buildInfoSection('User Email', orderData!.email!),
                if (orderData?.phoneNumber != null)
                  _buildInfoSection('User Phone', orderData!.phoneNumber!),
                if (orderData?.date != null)
                  _buildInfoSection('date', orderData!.date!),
                if (orderData?.time != null)
                  _buildInfoSection('time', orderData!.time!),
                if (orderData?.price != null)
                  _buildInfoSection('price ?', orderData!.price!),
                if (orderData?.isPaid != null)
                  _buildInfoSection('paid ?', orderData!.isPaid!),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: orderData!.isRead == false
                        ? makeOrderDone
                        : () {
                            print("object");
                          },
                    // Handle action, e.g., mark order as completed

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, // Emerald Green
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.screenWidth * 0.08,
                        vertical: Constants.screenHeight * 0.017,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: Text(
                      orderData!.isRead == false
                          ? 'Mark as Completed'
                          : "Completed",
                      style: TextStyle(
                        fontSize: Constants.screenWidth * 0.04,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Constants.screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002B5B), // Navy Blue
          ),
        ),
        SizedBox(height: Constants.screenHeight * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Constants.screenWidth * 0.04),
          margin: EdgeInsets.only(bottom: Constants.screenHeight * 0.02),
          decoration: BoxDecoration(
            color: Colors.white,
            // Card Background
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            // Light Gray Border
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), // Subtle Shadow
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: Constants.screenWidth * 0.04,
              color: const Color(0xFF333333), // Dark Text
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
