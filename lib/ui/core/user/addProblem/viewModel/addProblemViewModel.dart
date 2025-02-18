import 'package:flutter/cupertino.dart';
import 'package:qr_code/data/repositires/problems/addProblemRepo.dart';
import 'package:qr_code/data/services/shared_pref_helper.dart';
import 'package:qr_code/domain/models/addProblemModel.dart';
import 'package:qr_code/ui/core/user/addProblem/connector/addProblemConnector.dart';
import 'package:qr_code/utils/base.dart';

class AddProblemViewModel extends BaseViewModel<AddProblemConnector> {
  AddProblemRepo addProblemRepo;
  bool _isLoading = false;
  bool _isDone = false;

  bool get isLoading => _isLoading;

  bool get isDone => _isDone;

  AddProblemViewModel(this.addProblemRepo);

  uploadProblem({required TextEditingController problemController}) {
    {
      bool nullable = checkNullable(problem: problemController.text);
      if (nullable == true) {
        return connector!.onError("Please Enter Your Problem");
      } else {
        try {
          AddProblemModel addProblemModel = AddProblemModel(
              address: "address",
              email: SharedPreferencesHelper.email,
              compound: SharedPreferencesHelper.compoundName,
              phone: "01114324251",
              problem: problemController.text);
          setLoading(true);
          addProblemRepo.uploadProblem(problem: addProblemModel);
          _isDone = true;
          setLoading(false);
          problemController.clear();
        } catch (e) {
          return connector!.onError(e.toString());
        }
      }
    }
  }

  bool checkNullable({required String problem}) {
    if (problem.toString().trim().isEmpty || problem.toString().trim() == '') {
      return true;
    }
    return false;
  }

  setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
