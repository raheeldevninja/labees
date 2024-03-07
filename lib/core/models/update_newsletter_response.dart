import 'package:labees/core/models/user.dart';

class UpdateNewsletterResponse {
  User? user;
  String? message;
  bool? status;

  UpdateNewsletterResponse({this.user, this.message, this.status});

  UpdateNewsletterResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

