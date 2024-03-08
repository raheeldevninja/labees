class AttributeDetails {
  int? id;
  String? name;
  String? categories;
  String? subCategories;
  String? subSubCategories;
  int? showInFilter;
  String? createdAt;
  String? updatedAt;
  List<AttributeValues>? attributeValues;

  AttributeDetails({
    this.id,
    this.name,
    this.categories,
    this.subCategories,
    this.subSubCategories,
    this.showInFilter,
    this.createdAt,
    this.updatedAt,
    this.attributeValues,
  });

  AttributeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categories = json['categories'];
    subCategories = json['sub_categories'];
    subSubCategories = json['sub_sub_categories'];
    showInFilter = json['show_in_filter'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['attribute_values'] != null) {
      attributeValues = <AttributeValues>[];
      json['attribute_values'].forEach((v) {
        attributeValues!.add(new AttributeValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categories'] = this.categories;
    data['sub_categories'] = this.subCategories;
    data['sub_sub_categories'] = this.subSubCategories;
    data['show_in_filter'] = this.showInFilter;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.attributeValues != null) {
      data['attribute_values'] =
          this.attributeValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeValues {
  int? id;
  int? attributeId;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  bool isSelected = false;

  AttributeValues(
      {this.id,
      this.attributeId,
      this.name,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.isSelected = false});

  AttributeValues copyWith({
    int? id,
    int? attributeId,
    String? name,
    String? image,
    String? createdAt,
    String? updatedAt,
    bool? isSelected,
  }) {
    return AttributeValues(
      id: id ?? this.id,
      attributeId: attributeId ?? this.attributeId,
      name: name ?? this.name,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  AttributeValues.fromJson(Map<String, dynamic> json) {
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
