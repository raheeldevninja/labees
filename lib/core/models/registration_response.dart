class RegistrationResponse {
  String? token;

  bool? success;
  String? message;


  RegistrationResponse({this.token, this.success, this.message});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
