class OwnerModel {
  String name;

  String email;
  String id;
  String role;

  String address;
  bool isValid;

  OwnerModel(
      {required this.name,
      required this.email,
      required this.isValid,
      required this.address,
      required this.id,
      this.role = 'user'});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "isValid": isValid,
      "role": role,
      "address": address,
      "id": id,
    };
  }

  static OwnerModel fromJson(Map<String, dynamic> json) {
    OwnerModel owner = OwnerModel(
        name: json['name'],
        email: json['email'],
        isValid: json['isValid'],
        address: json['address'],
        id: json['id']);
    return owner;
  }
}
