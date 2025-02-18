import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/data/services/data_base/owners/get_owners_firebase_servie.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/error_widget.dart';
import 'package:qr_code/utils/base.dart';
import 'package:qr_code/utils/constants.dart';

import '../../../../../data/repositires/firebaseAuth/get_owners.dart';
import '../../../../../utils/app_colors.dart';
import '../connector/valid_user_connedtor.dart';
import '../view_model/add_user_valid_view_model.dart';

class AddUsersValidated extends StatefulWidget {
  const AddUsersValidated({super.key});

  @override
  State<AddUsersValidated> createState() => _AddUsersValidatedState();
}

class _AddUsersValidatedState
    extends BaseView<AddUserValidViewModel, AddUsersValidated>
    implements ValidUserConnector {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
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
        body: Padding(
          padding: EdgeInsets.all(Constants.screenWidth * 0.01),
          child: Column(
            children: [
              Expanded(child: viewModel.showOwners()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  onError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(message);
      return error_widget(context: context, message: message);
    });
  }

  @override
  showLoading() {
    // TODO: implement showLoading
    return CircularProgressIndicator();
  }

  @override
  AddUserValidViewModel init_my_view_model() {
    GetOwnerFirebaseService getOwnerFirebaseService = GetOwnerFirebaseService();
    GetOwnersRepo getOwnersRepo = GetOwnersRepo(getOwnerFirebaseService);
    // TODO: implement init_my_view_model
    return AddUserValidViewModel(getOwnersRepo);
  }
}
