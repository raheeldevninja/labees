class TicketSupportDetailsResponse {
  Ticket? ticket;
  List<Conversations>? conversations;

  String? message;
  bool? success;

  TicketSupportDetailsResponse({this.ticket, this.conversations, this.message, this.success});

  TicketSupportDetailsResponse.fromJson(Map<String, dynamic> json) {
    ticket =
    json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(new Conversations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ticket != null) {
      data['ticket'] = this.ticket!.toJson();
    }
    if (this.conversations != null) {
      data['conversations'] =
          this.conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ticket {
  int? id;
  int? customerId;
  String? subject;
  String? type;
  String? priority;
  String? description;
  String? reply;
  String? expectedSolveDate;
  int? adminId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Ticket(
      {this.id,
        this.customerId,
        this.subject,
        this.type,
        this.priority,
        this.description,
        this.reply,
        this.expectedSolveDate,
        this.adminId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    subject = json['subject'];
    type = json['type'];
    priority = json['priority'];
    description = json['description'];
    reply = json['reply'];
    expectedSolveDate = json['expected_solve_date'];
    adminId = json['admin_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['subject'] = this.subject;
    data['type'] = this.type;
    data['priority'] = this.priority;
    data['description'] = this.description;
    data['reply'] = this.reply;
    data['expected_solve_date'] = this.expectedSolveDate;
    data['admin_id'] = this.adminId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Conversations {
  int? id;
  int? supportTicketId;
  int? adminId;
  String? customerMessage;
  String? adminMessage;
  int? position;
  String? createdAt;
  String? updatedAt;
  String? name;

  Conversations(
      {this.id,
        this.supportTicketId,
        this.adminId,
        this.customerMessage,
        this.adminMessage,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.name});

  Conversations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supportTicketId = json['support_ticket_id'];
    adminId = json['admin_id'];
    customerMessage = json['customer_message'];
    adminMessage = json['admin_message'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['support_ticket_id'] = this.supportTicketId;
    data['admin_id'] = this.adminId;
    data['customer_message'] = this.customerMessage;
    data['admin_message'] = this.adminMessage;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}
