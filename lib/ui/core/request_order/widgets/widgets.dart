//
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';

Widget editableContainer({
  required bool isEditing,
  required TextEditingController editingController,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeInOut,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primary.withOpacity(0.6), width: 2),
      color: isEditing ? Colors.blueAccent.withOpacity(0.1) : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: isEditing
        ? TextFormField(
            controller: editingController,
            decoration: InputDecoration(
              hintText: "Enter your details...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.blueAccent.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
            ),
          )
        : edit_locatino(isEditing),
  );
}

edit_locatino(bool isEditing) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Delivery Address',
            style: TextStyle(
              color: const Color(0xFF1a1e1f),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          InkWell(
            onTap: () async {
              // add logic
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                color: isEditing ? Colors.blueAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                boxShadow: isEditing
                    ? [BoxShadow(color: Colors.blueAccent, blurRadius: 5)]
                    : [],
              ),
              child: Text(
                isEditing ? 'Loading...' : 'Edit',
                style: TextStyle(
                  color: isEditing ? Colors.white : const Color(0xFF00456B),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              "Your current location Your current Your current location Your current location  location Your current",
              style: TextStyle(
                color: Color(0xFF515554),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget text_form_field(
    {required String label,
    required double height,
    required IconData icon,
    required TextEditingController controller}) {
  return SizedBox(
    height: height,
    child: TextFormField(
      maxLines: 4,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.04),
          borderSide:
              BorderSide(color: AppColors.primary.withOpacity(0.6), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.04),
          borderSide: BorderSide(color: AppColors.primary, width: 2.5),
        ),
        filled: true,
        fillColor: AppColors.primary.withOpacity(0.1),
        prefixIcon: Icon(icon, color: AppColors.primary),
      ),
      cursorColor: AppColors.primary,
      style: const TextStyle(color: Colors.black87, fontSize: 16),
    ),
  );
}

// Widget show_payment_name({required String paymentName}) {
//   return InkWell(
//     onTap: () {},
//     child: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(paymentName,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//           Icon(Icons.check_circle, color: Colors.green),
//         ],
//       ),
//     ),
//   );
// }
