class Brand {
  int? id;
  String? name;
  String? image;
  int? homeStatus;
  int? status;
  String? createdAt;
  String? updatedAt;

  bool isSelected = false;

  Brand({
    this.id,
    this.name,
    this.image,
    this.homeStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isSelected = false,
  });

  Brand copyWith({
    int? id,
    String? name,
    String? image,
    int? homeStatus,
    int? status,
    String? createdAt,
    String? updatedAt,
    bool? isSelected,
  }) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      homeStatus: homeStatus ?? this.homeStatus,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    homeStatus = json['home_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['home_status'] = this.homeStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
