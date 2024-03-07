class Tag {
  int? id;
  String? name;
  int? sellerVisible;
  String? createdAt;
  String? updatedAt;

  bool isSelected = false;

  Tag(
      {this.id,
        this.name,
        this.sellerVisible,
        this.createdAt,
        this.updatedAt,
        this.isSelected = false,
      });

  Tag copyWith({
    int? id,
    String? name,
    int? sellerVisible,
    String? createdAt,
    String? updatedAt,
    bool? isSelected,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      sellerVisible: sellerVisible ?? this.sellerVisible,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sellerVisible = json['seller_visible'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['seller_visible'] = this.sellerVisible;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}