import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/ui/core/add_users_validated/widgets/valid_user_connedtor.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../utils/app_colors.dart';
import '../view_model/add_user_valid_view_model.dart';

class AddUsersValidated extends StatefulWidget {
  const AddUsersValidated({super.key});

  @override
  State<AddUsersValidated> createState() => _AddUsersValidatedState();
}

AddUserValidViewModel viewModel = AddUserValidViewModel();

class _AddUsersValidatedState extends State<AddUsersValidated>
    implements ValidUserConnector {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  showUsers({
    required String id,
    required String email,
    required String name,
    required String address,
    required bool isValid,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.01),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Constants.screenWidth * 0.04),
                child: user_data(
                    id: id,
                    email: email,
                    address: address,
                    isValid: isValid,
                    name: name,
                    phoneNumber: "01114324251"))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add user validated',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Constants.screenWidth * 0.052,
                color: AppColors.primary,
              )),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(child: viewModel.showOwners()),
          ],
        ),
      ),
    );
  }

  Widget user_data({
    required String email,
    required String name,
    required String id,
    required String address,
    required String phoneNumber,
    required bool isValid,
  }) {
    return Container(
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
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Constants.screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.screenWidth * 0.038,
                  ),
                ),
                Text(
                  address,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.screenWidth * 0.038,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (!isValid) {
                print("object");
                viewModel.update_validation(id: id);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Constants.screenWidth * 0.02,
                  vertical: Constants.screenHeight * 0.01),
              decoration: BoxDecoration(
                color: isValid ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(
                  Constants.screenWidth * 0.03,
                ),
              ),
              child: Row(
                children: [
                  if (isValid)
                    Icon(Icons.check_circle, color: Colors.white, size: 20.0),
                  SizedBox(
                    width: Constants.screenWidth * 0.01,
                  ),
                  Text(
                    isValid ? "Valid" : "add validated",
                    style: TextStyle(
                      color: isValid ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
