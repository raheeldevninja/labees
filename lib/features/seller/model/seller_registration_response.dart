class SellerRegistrationResponse {
  String? message;
  bool? success;

  SellerRegistrationResponse({this.message, this.success});

  SellerRegistrationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
