class DeleteTicketSupportResponse {
  String? message;
  bool? success;

  DeleteTicketSupportResponse({this.message, this.success});

  DeleteTicketSupportResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
