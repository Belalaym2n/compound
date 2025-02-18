import 'dart:core';

import 'package:flutter/material.dart';
import 'package:qr_code/domain/models/owner_model.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';

class OwnerData extends StatelessWidget {
  OwnerData({
    super.key,
    required this.ownerModel,
    required this.makeValid,
  });

  Function makeValid;

  OwnerModel ownerModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constants.screenWidth * 0.04),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: Constants.screenWidth * 0.012,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  owner_text_data(data: ownerModel.email),
                  const SizedBox(height: 4.0),
                  owner_text_data(data: ownerModel.name),
                  owner_text_data(data: ownerModel.address),
                  owner_text_data(data: ownerModel.compoundName),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (!ownerModel.isValid) {
                  makeValid();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.screenWidth * 0.02,
                    vertical: Constants.screenHeight * 0.01),
                decoration: BoxDecoration(
                  color: ownerModel.isValid ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(
                    Constants.screenWidth * 0.03,
                  ),
                ),
                child: Row(
                  children: [
                    if (ownerModel.isValid)
                      Icon(Icons.check_circle,
                          color: Colors.white,
                          size: Constants.screenWidth * 0.05),
                    SizedBox(
                      width: Constants.screenWidth * 0.01,
                    ),
                    Text(
                      ownerModel.isValid ? "Valid" : "add validated",
                      style: TextStyle(
                        color: ownerModel.isValid ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  owner_text_data({required String data}) {
    return Text(
      data,
      style: TextStyle(
        color: Colors.white,
        fontSize: Constants.screenWidth * 0.03,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
