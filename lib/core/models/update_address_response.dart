class UpdateAddressResponse {
  String? message;
  bool? success;

  UpdateAddressResponse({this.success, this.message});

  UpdateAddressResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
