class AddressModel {
  int? id;
  String contactPersonName;
  String addressType;
  String address;
  int isBilling;
  int country;
  int city;
  String zip;
  String phone;
  String phoneCode;
  String? latitude;
  String? longitude;

  AddressModel({
    this.id,
    required this.contactPersonName,
    required this.addressType,
    required this.address,
    required this.isBilling,
    required this.country,
    required this.city,
    required this.zip,
    required this.phone,
    required this.phoneCode,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['contact_person_name'] = this.contactPersonName;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['is_billing'] = this.isBilling;
    data['country'] = this.country;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['phone_code'] = this.phoneCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  @override
  String toString() {
    return 'AddressData{contactPersonName: $contactPersonName, addressType: $addressType, address: $address, isBilling: $isBilling, country: $country, city: $city, zip: $zip, phone: $phone, phoneCode: $phoneCode, latitude: $latitude, longitude: $longitude}';
  }

  //query string
  String queryString() =>
      '?contact_person_name=$contactPersonName&address_type=$addressType&address=$address&is_billing=$isBilling&country=$country&city=$city&zip=$zip&phone=$phone&phone_code=$phoneCode&latitude=$latitude&longitude=$longitude';
}
