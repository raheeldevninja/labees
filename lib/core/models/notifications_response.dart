class NotificationsResponse {
  bool success = false;
  String? message;

  List<Notifications>? notifications;

  NotificationsResponse(
      {this.success = false, this.message, this.notifications});
}

class Notifications {
  int? id;
  String? title;
  String? description;
  int? notificationCount;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  Notifications(
      {this.id,
      this.title,
      this.description,
      this.notificationCount,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    notificationCount = json['notification_count'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['notification_count'] = this.notificationCount;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
