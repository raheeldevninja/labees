class AddressData {
  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  int? city;
  String? zip;
  String? phone;
  String? phoneCode;
  String? createdAt;
  String? updatedAt;
  String? state;
  int? country;
  String? latitude;
  String? longitude;
  int? isBilling;
  int? isDefault;

  AddressData(
      {this.id,
      this.customerId,
      this.contactPersonName,
      this.addressType,
      this.address,
      this.city,
      this.zip,
      this.phone,
      this.phoneCode,
      this.createdAt,
      this.updatedAt,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.isBilling,
      this.isDefault});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    phoneCode = json['phone_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isBilling = json['is_billing'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['contact_person_name'] = this.contactPersonName;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['phone_code'] = this.phoneCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_billing'] = this.isBilling;
    data['is_default'] = this.isDefault;
    return data;
  }
}
