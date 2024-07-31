class UserMode {
  String password;
  String address;
  String id;
  String phoneNumber;
  bool isAdmin;
  bool isSecurity;

  UserMode({
    required this.password,
    required this.address,
    required this.phoneNumber,
    required this.id,
    this.isAdmin = false,
    this.isSecurity = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'address': address,
      'phoneNumber': phoneNumber,
      'id': id,
      'is admin': isAdmin,
      'is security': isSecurity,
    };
  }
}
