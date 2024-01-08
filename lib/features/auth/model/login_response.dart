import 'package:labees/core/models/user.dart';

class LoginResponse {
  String? token;
  User? user;

  bool? success;
  String? message;

  LoginResponse({this.token, this.user, this.success = false, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
