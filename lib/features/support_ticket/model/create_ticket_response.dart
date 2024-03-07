class CreateTicketResponse {
  String? message;
  bool? status;

  CreateTicketResponse({this.message, this.status});

  CreateTicketResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
