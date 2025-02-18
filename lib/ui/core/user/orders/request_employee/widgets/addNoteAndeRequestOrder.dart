import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/elevated_button.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/text_form_field_in_order.dart';
import 'package:qr_code/utils/base.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../../data/services/shared_pref_helper.dart';
import '../../../../ui/sharedWidgets/add_note_widget.dart';
import '../../../../ui/sharedWidgets/shared_widgets.dart';
import '../../../../ui/sharedWidgets/success_widget.dart';
import '../../best_controller/widget/step_two_widget.dart';
import '../connector/request_employee_connector.dart';
import '../view_model/request_employee_view_model.dart';

class AddNoteAndeRequestOrder extends StatefulWidget {
  AddNoteAndeRequestOrder({super.key, required this.employeeName});

  String employeeName;

  @override
  State<AddNoteAndeRequestOrder> createState() =>
      _AddNoteAndeRequestOrderState();
}

class _AddNoteAndeRequestOrderState
    extends BaseView<RequestEmployeeViewModel, AddNoteAndeRequestOrder>
    implements RequestEmployeeConnector {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
    SharedPreferencesHelper.loadUserDataForOrders(
        phoneController: phoneNumberController,
        addressController: addressController);
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) => Consumer<RequestEmployeeViewModel>(
          builder: (context, viewModel, child) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Dynamic padding for the keyboard
                left: 20,
                right: 20,
              ),
              child: viewModel.isDoneOrder == false
                  ? Column(
                      children: [
                        SizedBox(height: Constants.screenHeight * 0.11),
                        servic_name(serviceName: widget.employeeName),
                        SizedBox(height: Constants.screenHeight * 0.038),
                        text_form_field_in_order(
                          controller: addressController,
                          label: "Add Address",
                          height: Constants.screenHeight * 0.14,
                          icon: Icons.location_on,
                        ),
                        SizedBox(height: Constants.screenHeight * 0.018),
                        space_divider(),
                        SizedBox(height: Constants.screenHeight * 0.018),
                        text_form_field_in_order(
                          controller: phoneNumberController,
                          label: "Phone",
                          height: Constants.screenHeight * 0.06,
                          icon: Icons.phone_callback_outlined,
                        ),
                        SizedBox(height: Constants.screenHeight * 0.018),
                        space_divider(),
                        SizedBox(height: Constants.screenHeight * 0.018),
                        add_note_widget(context),
                        SizedBox(height: Constants.screenHeight * 0.03),
                        elevated_button(
                          loading: viewModel.isLoading,
                          onPressed: () {
                            viewModel.send_order_to_database(
                              employeeName: widget.employeeName,
                              phoneController: phoneNumberController,
                              addressController: addressController,
                              noteController: noteController,
                            );
                          },
                          buttonName: "Request",
                        ),
                      ],
                    )
                  : done_order_widget(context),
            ),
          ),
        ),
      ),
    ));
  }

  @override
  RequestEmployeeViewModel init_my_view_model() {
    // TODO: implement init_my_view_model
    return RequestEmployeeViewModel();
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
