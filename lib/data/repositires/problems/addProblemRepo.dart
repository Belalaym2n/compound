import 'package:qr_code/data/services/addProblemService/addProblemService.dart';
import 'package:qr_code/domain/models/addProblemModel.dart';

class AddProblemRepo {
  AddProblemService _addProblemService;

  AddProblemRepo(this._addProblemService);

  uploadProblem({required AddProblemModel problem}) {
    return _addProblemService.uploadProblem(problem: problem);
  }
}
