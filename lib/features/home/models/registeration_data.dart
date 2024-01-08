class RegistrationData {
  String fName;
  String lName;
  String email;
  String phone;
  String password;

  RegistrationData({
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.password,
  });

  //to map
  Map<String, dynamic> toMap() {
    return {
      'f_name': fName,
      'l_name': lName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

}