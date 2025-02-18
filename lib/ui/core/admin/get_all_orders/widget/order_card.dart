import 'package:flutter/material.dart';
import 'package:qr_code/domain/models/order_data.dart';
import 'package:qr_code/utils/app_colors.dart';

import '../view/order_detailed_screen.dart';

class OrderCard extends StatelessWidget {
  OrderData orderData;
  VoidCallback makeOrderDone;

  OrderCard({
    Key? key,
    required this.makeOrderDone,
    required this.orderData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: orderData.isRead == true
              ? LinearGradient(
                  colors: [Colors.green, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.white, Colors.grey[200]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Name
            Center(
              child: Text(
                orderData.service.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      orderData.isRead == true ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const Divider(thickness: 1, color: Colors.grey),

            // Compound Name
            _buildInfoRow(Icons.location_city, 'Compound',
                orderData.compoundName.toString()),

            // User Address

            // User Email
            _buildInfoRow(Icons.email, 'Email', orderData.email.toString()),

            // User Phone
            _buildInfoRow(
                Icons.phone, 'Phone', orderData.phoneNumber.toString()),

            // Action Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailedScreen(
                              makeOrderDone: makeOrderDone,
                              orderData: orderData)));
                  // Define button action
                },
                icon: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: orderData.isRead == true
                      ? AppColors.primary
                      : Colors.white,
                ),
                label: Text(
                  'View Details',
                  style: TextStyle(
                      color: orderData.isRead == true
                          ? AppColors.primary
                          : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: orderData.isRead == true
                      ? Colors.white
                      : AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              size: 20,
              color: orderData.isRead == true ? Colors.white : Colors.blueGrey),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: orderData.isRead == true ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: orderData.isRead == true ? Colors.white : Colors.black54,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
