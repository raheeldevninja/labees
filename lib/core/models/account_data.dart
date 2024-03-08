/*
*  Date 12 - Now-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Account Data
*/

class AccountData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final String oldPassword;
  final String newPassword;

  AccountData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['f_name'] = this.firstName;
    data['l_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['old_password'] = this.oldPassword;
    data['password'] = this.newPassword;
    return data;
  }
}
