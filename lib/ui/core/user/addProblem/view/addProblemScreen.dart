import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/data/repositires/problems/addProblemRepo.dart';
import 'package:qr_code/data/services/addProblemService/addProblemService.dart';
import 'package:qr_code/ui/core/user/addProblem/connector/addProblemConnector.dart';
import 'package:qr_code/ui/core/user/addProblem/viewModel/addProblemViewModel.dart';
import 'package:qr_code/ui/core/user/addProblem/widget/addProblemItem.dart';
import 'package:qr_code/utils/base.dart';

import '../../../ui/sharedWidgets/checkIneternet.dart';
import '../../../ui/sharedWidgets/error_widget.dart';

class AddProblemScreen extends StatefulWidget {
  const AddProblemScreen({super.key});

  @override
  State<AddProblemScreen> createState() => _AddProblemScreenState();
}

class _AddProblemScreenState
    extends BaseView<AddProblemViewModel, AddProblemScreen>
    implements AddProblemConnector {
  TextEditingController problemController = TextEditingController();

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
        child: Consumer<AddProblemViewModel>(
            builder: (context, viewModel, child) => InternetWrapper(
                child: AddProblemItem(
                    isLoading: viewModel.isLoading,
                    isDone: viewModel.isDone,
                    problemController: problemController,
                    submitProblem: () {
                      viewModel.uploadProblem(
                          problemController: problemController);
                    }))));
  }

  @override
  AddProblemViewModel init_my_view_model() {
    AddProblemService _addProblemService = AddProblemService();
    AddProblemRepo addProblemRepo = AddProblemRepo(_addProblemService);
    // TODO: implement init_my_view_model
    return AddProblemViewModel(addProblemRepo);
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
