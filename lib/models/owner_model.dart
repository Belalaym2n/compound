class OwnerModel {
  String name;

  String email;
  String id;
  String role;

  String address;

  OwnerModel(
      {required this.name,
      required this.email,
      required this.address,
      required this.id,
      this.role = 'user'});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "role": role,
      "address": address,
      "id": id,
    };
  }
}
