class DeleteAddressResponse {
  String? message;
  bool? success;

  DeleteAddressResponse({this.success, this.message});

  DeleteAddressResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
