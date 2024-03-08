class Cities {
  bool success = false;
  String? message;

  List<CitiesData>? data;

  Cities({this.success = false, this.message, this.data});
}

class CitiesData {
  int? id;
  String? name;
  int? countryId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? nameEn;

  CitiesData({
    this.id,
    this.name,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.nameEn,
  });

  CitiesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name_en'] = this.nameEn;
    return data;
  }
}
