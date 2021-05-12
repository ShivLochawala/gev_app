class User {
  int id;
  String name;
  String countryCode;
  String phone;
  String email;
  String address;
  String dob;

  User({this.id, this.name, this.countryCode, this.phone, this.email, this.address, this.dob,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      countryCode: json["country_code"].toString(),
      phone: json["phone"].toString(),
      email: json["email"],
      address: json["address"],
      dob: json["dob"]
    );
  }
}