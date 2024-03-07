class TicketSupportData {

  String subject;
  String type;
  String priority;
  String description;

  TicketSupportData({
    required this.subject,
    required this.type,
    required this.priority,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'type': type,
      'priority': priority,
      'description': description,
    };
  }

  factory TicketSupportData.fromJson(Map<String, dynamic> json) {
    return TicketSupportData(
      subject: json['subject'],
      type: json['type'],
      priority: json['priority'],
      description: json['description'],
    );
  }
}