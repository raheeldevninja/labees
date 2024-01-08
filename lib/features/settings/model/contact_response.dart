class ContactResponse {
  String? message;
  bool? success;

  ContactResponse({this.message, this.success});

  ContactResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    return data;
  }
}
