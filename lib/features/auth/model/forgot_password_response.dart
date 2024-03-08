class ForgotPasswordResponse {
  bool? status;
  String? message;

  ForgotPasswordResponse({this.status, this.message});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
