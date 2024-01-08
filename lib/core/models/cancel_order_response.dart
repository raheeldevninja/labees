class CancelOrderResponse {
  String? message;
  bool? success;

  CancelOrderResponse({this.success, this.message});

  CancelOrderResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
