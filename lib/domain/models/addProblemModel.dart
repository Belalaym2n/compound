class AddProblemModel {
  String? address;
  String? email;
  String? phone;
  String? compound;
  String? problem;

  AddProblemModel(
      {this.address, this.email, this.compound, this.problem, this.phone});

  factory AddProblemModel.fromJson(Map<String, dynamic> json) {
    return AddProblemModel(
      address: json['address'],
      email: json['email'],
      problem: json['problem'],
      compound: json['compound'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'email': email,
      'compound': compound,
      'problem': problem,
      'phone': phone,
    };
  }
}
