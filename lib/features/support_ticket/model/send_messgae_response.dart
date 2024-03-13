class SendMessageResponse {
  Support? support;
  String? message;
  bool? status;

  SendMessageResponse({this.support, this.message, this.status});

  SendMessageResponse.fromJson(Map<String, dynamic> json) {
    support =
    json['support'] != null ? new Support.fromJson(json['support']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Support {
  int? supportTicketId;
  String? customerMessage;
  String? updatedAt;
  String? createdAt;
  int? id;

  Support(
      {this.supportTicketId,
        this.customerMessage,
        this.updatedAt,
        this.createdAt,
        this.id});

  Support.fromJson(Map<String, dynamic> json) {
    supportTicketId = json['support_ticket_id'];
    customerMessage = json['customer_message'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['support_ticket_id'] = this.supportTicketId;
    data['customer_message'] = this.customerMessage;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
