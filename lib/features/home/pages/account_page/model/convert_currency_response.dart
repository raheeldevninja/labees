class ConvertToCurrencyResponse {
  String? message;
  bool? status;

  ConvertToCurrencyResponse({this.message, this.status});

  ConvertToCurrencyResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
