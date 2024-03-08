class Options {
  int? id;
  int? attributeId;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  bool isSelected = false;

  Options({
    this.id,
    this.attributeId,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSelected = false,
  });

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeId = json['attribute_id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute_id'] = this.attributeId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
