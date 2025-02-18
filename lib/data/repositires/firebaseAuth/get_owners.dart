import 'package:qr_code/data/services/data_base/owners/get_owners_firebase_servie.dart';

class GetOwnersRepo {
  GetOwnerFirebaseService getOwnerFirebaseService;

  GetOwnersRepo(this.getOwnerFirebaseService);

  Stream<List<dynamic>> getOwner() {
    try {
      final ownersStream = getOwnerFirebaseService.getOwners();
      return ownersStream;
    } catch (e) {
      throw Exception("Failed to fetch owners: ${e.toString()}");
    }
  }
}
