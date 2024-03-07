class TicketSupportResponse {
  String? message;
  bool? success;
  List<TicketSupportListResponse>? data;

  TicketSupportResponse({this.message, this.success, this.data});
}

class TicketSupportListResponse {
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

  String? message;
  bool? success;

  TicketSupportListResponse(
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
        this.updatedAt,
        this.message,
        this.success
      });

  TicketSupportListResponse.fromJson(Map<String, dynamic> json) {
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
