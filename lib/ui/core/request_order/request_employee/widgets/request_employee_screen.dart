import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/request_order/request_employee/widgets/addNoteAndeRequestOrder.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/base.dart';

import '../../../../../utils/app_images.dart';
import '../../../../../utils/constants.dart';
import '../view_model/request_employee_view_model.dart';

class RequestEmployeeScreen extends StatefulWidget {
  const RequestEmployeeScreen({super.key});

  @override
  State<RequestEmployeeScreen> createState() => _RequestEmployeeScreenState();
}

class _RequestEmployeeScreenState
    extends BaseView<RequestEmployeeViewModel, RequestEmployeeScreen> {
  bool isExpanded = false; // للتحكم في حالة توسيع الويدجيت
  List<String> employees = [
    "John Doe",
    "Jane Smith",
    "Michael Brown",
    "Michael sdfa",
    "Michael fs",
    "Michael sf",
    "Michael Brown"
  ]; // قائمة الموظفين

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // viewModel.initializeSelection(employees.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Request Employee",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => viewModel,
          builder: (context, child) => Consumer<RequestEmployeeViewModel>(
            builder: (context, viewModel, child) => Column(
              children: [
                showImage(),
                chooseEmployee(),
              ],
            ),
          ),
        ));
  }

  Widget showImage() {
    return Image.asset(
      AppImages.request_employe,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      fit: BoxFit.fitWidth,
    );
  }

  Widget chooseEmployee() {
    return AnimatedContainer(
      height: isExpanded
          ? Constants.screenHeight * 0.4
          : Constants.screenHeight * 0.08,
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.all(
        Constants.screenWidth * 0.04,
      ),
      padding: EdgeInsets.all(
        Constants.screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.04),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 5),
            ),
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose Employee",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded; // توسيع أو تصغير الويدجيت
                    });
                  },
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: Constants.screenWidth * 0.1,
                    weight: Constants.screenWidth * 0.1,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            if (isExpanded) // عرض قائمة الموظفين فقط إذا تم التوسيع
              SizedBox(
                height: Constants.screenHeight * 0.4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      bool isSelected = viewModel.selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          viewModel.toggleSelection(index);
                          Future.delayed(
                            Duration(milliseconds: 200),
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddNoteAndeRequestOrder(
                                      employeeName: employees[index],
                                    ),
                                  ));
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: Constants.screenWidth * 0.035,
                            horizontal: Constants.screenWidth * 0.04,
                          ),
                          margin: EdgeInsets.only(
                            bottom: Constants.screenWidth * 0.037,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? AppColors.primary : Colors.white,
                            borderRadius: BorderRadius.circular(
                              Constants.screenWidth * 0.06,
                            ),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Text(
                            employees[index],
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.w400,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade800,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  RequestEmployeeViewModel init_my_view_model() {
    // TODO: implement init_my_view_model
    return RequestEmployeeViewModel();
  }

  @override
  onError(String message) {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    throw UnimplementedError();
  }
}
