import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qr_code/data/services/notification_api.dart';
import 'package:qr_code/utils/app_colors.dart';

import '../../../../domain/models/notification_order.dart';
import '../widgets/connector.dart';

class RequestOrderViewModel extends ChangeNotifier {
  late RequestOrderConnector connector;
  ApiNotification apiNotification = ApiNotification();
  bool isComplete = false;
  bool complete = true;
  int index = 0;

  onStepCancel() {
    if (index > 0) {
      index = index - 1;
      notifyListeners();
    }
  }

  onStepContinue({
    required TextEditingController noteController,
    required TextEditingController phoneController,
    required TextEditingController addressController,
    required String externalID,
  }) async {
    bool fieldsAreValid = check_fields_not_null(
      phoneController: phoneController,
      addressController: addressController,
    );
    print("object $fieldsAreValid");

    if (fieldsAreValid) {
      if (index == 2) {
        //Send notification when confirming the order
        await send_notification_for_technical_support(
          externalId: externalID,
          name: noteController.text,
          phone: phoneController.text,
          address: addressController.text,
        );
        await send_order_for_database(
            externalId: externalID,
            heading: "New Order",
            order:
                " name is :${noteController.text} \n Address is :${addressController.text} \n phone is :${phoneController.text}");
      }

      // Move to the next step if it's not the last one
      if (index < steps.length - 1) {
        index += 1;
        notifyListeners();
      }
    }
  }

  bool check_fields_not_null({
    TextEditingController? noteController,
    required TextEditingController phoneController,
    required TextEditingController addressController,
  }) {
    if (index == 0) {
      if (phoneController.text.isEmpty || addressController.text.isEmpty) {
        connector.errorMessage("All Field Must Be Not Empty");
        return false;
      }
    }
    return true;
  }

  List<Step> get steps => [
        Step(
          stepStyle: index > 0
              ? StepStyle(
                  indexStyle: TextStyle(color: Colors.white),
                  color: AppColors.primary)
              : StepStyle(
                  indexStyle: TextStyle(color: Colors.white),
                  color: AppColors.primary),
          isActive: index > 0,
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: index == 0 ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: index == 0 ? AppColors.primary : Colors.grey,
            ),
            child: connector.tittleName("Contact information"),
          ),
          content: Column(
            children: [connector.step_one_content()],
          ),
        ),
        Step(
            stepStyle: index > 1
                ? StepStyle(
                    indexStyle: TextStyle(color: Colors.white),
                    color: AppColors.primary)
                : StepStyle(
                    indexStyle: TextStyle(color: AppColors.primary),
                    color: AppColors.primary),
            isActive: index > 1,
            title: connector.tittleName("Request Order"),
            content: connector.step_two_content()),
        Step(
            stepStyle: index > 3
                ? StepStyle(
                    indexStyle: TextStyle(color: Colors.white),
                    color: AppColors.primary)
                : StepStyle(
                    indexStyle: TextStyle(color: AppColors.primary),
                    color: AppColors.primary),
            isActive: index > 2,
            title: connector.tittleName("payment"),
            content: connector.final_step_content()),
      ];

  send_notification_for_technical_support({
    required String name,
    required String phone,
    required String address,
    required String externalId,
  }) async {
    Response response = await apiNotification.post_data(
        externalId: externalId,
        message: "name is :$name \n Address is :$address \n phone is :$phone");

    try {
      if (response.statusCode == 200) {
        print('تم إرسال الإشعار بنجاح');
      } else {
        print('فشل إرسال الإشعار: ${response.body}');
      }
    } catch (e) {
      print('خطأ في إرسال الإشعار: $e');
    }
  }

  send_order_for_database({
    required String externalId,
    required String heading,
    required String order,
  }) {
    NotificationOrder requestOrder = NotificationOrder(
        heading: heading,
        order: order,
        time: DateUtils.dateOnly(DateTime.now()).toString());

    var collection = FirebaseFirestore.instance
        .collection("Orders")
        .doc(externalId)
        .collection("Orders");
    var docref = collection.doc();
    requestOrder.id = docref.id;

    docref.set(requestOrder.toJson());
    print("set data for firebase succesufflt");
  }
}
