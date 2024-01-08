class VerifyOTPResponse {
  String? message;
  bool? status;

  VerifyOTPResponse({this.message, this.status});

  VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
