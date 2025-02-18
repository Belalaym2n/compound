import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/ownerFirebaseDatabaseService/getOwners.dart';

class FirebaseDatabaseGetOwnersRepo {
  FirebaseDatabaseGetOwnersService firebaseDatabaseGetOwnersService;

  FirebaseDatabaseGetOwnersRepo(this.firebaseDatabaseGetOwnersService);

  Future<DocumentSnapshot> getUserDocument(String uid) async {
    return firebaseDatabaseGetOwnersService.getUserDocument(uid);
  }
}
