import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code/domain/models/addProblemModel.dart';

class AddProblemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadProblem({required AddProblemModel problem}) async {
    try {
      await _firestore
          .collection("Problems")
          .withConverter<AddProblemModel>(
            fromFirestore: (snapshot, _) =>
                AddProblemModel.fromJson(snapshot.data()!),
            toFirestore: (problem, _) => problem.toJson(),
          )
          .add(problem);
    } catch (e) {
      throw Exception("Error uploading problem: $e");
    }
  }
}
