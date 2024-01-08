class MyAddress {

  final String city;
  final String address;
  final String phone;

  MyAddress({
    required this.city,
    required this.address,
    required this.phone
  });

  MyAddress copyWith({String? city, String? address, String? phone}) {
    return MyAddress(
      city: city ?? this.city,
      address: address ?? this.address,
      phone: phone ?? this.phone
    );
  }


}