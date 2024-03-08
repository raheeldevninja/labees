class DefaultAddressResponse {
  String? message;
  bool? status;

  DefaultAddressResponse({this.message, this.status});

  DefaultAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    return data;
  }
}
