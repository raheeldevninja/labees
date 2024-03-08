class Countries {
  bool success = false;
  String? message;

  List<CountriesData>? data;

  Countries({this.success = false, this.message, this.data});
}

class CountriesData {
  int? id;
  String? name;
  String? isoCode;
  String? iso2Code;
  String? phoneCode;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? nameEn;

  CountriesData(
      {this.id,
      this.name,
      this.isoCode,
      this.iso2Code,
      this.phoneCode,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.nameEn});

  CountriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoCode = json['iso_code'];
    iso2Code = json['iso2_code'];
    phoneCode = json['phone_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iso_code'] = this.isoCode;
    data['iso2_code'] = this.iso2Code;
    data['phone_code'] = this.phoneCode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name_en'] = this.nameEn;
    return data;
  }
}
