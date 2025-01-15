import 'package:flutter/material.dart';
import 'package:qr_code/domain/models/order_data.dart';
import 'package:qr_code/utils/app_colors.dart';

class OrderDetailedScreen extends StatelessWidget {
  final OrderData? orderData;

  OrderDetailedScreen({
    required this.orderData,
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
                if (orderData?.area != null && orderData!.area!.isNotEmpty)
                  _buildInfoSection('Area', orderData!.area!),
                if (orderData?.date != null)
                  _buildInfoSection('date', orderData!.date!),
                if (orderData?.time != null)
                  _buildInfoSection('time', orderData!.time!),
                if (orderData?.isPaid != null)
                  _buildInfoSection('Compound Name', orderData!.isPaid!),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle action, e.g., mark order as completed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, // Emerald Green
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: const Text(
                      'Mark as Completed',
                      style: TextStyle(
                        fontSize: 16,
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002B5B), // Navy Blue
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
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
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF333333), // Dark Text
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
