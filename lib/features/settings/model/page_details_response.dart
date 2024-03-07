class PageDetailsResponse {
  int? id;
  String? name;
  String? description;
  String? slug;
  int? status;
  String? createdAt;
  String? updatedAt;

  String? message;
  bool? success;

  PageDetailsResponse(
      {this.id,
        this.name,
        this.description,
        this.slug,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.message,
        this.success
      });

  PageDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
