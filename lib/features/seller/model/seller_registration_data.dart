class SellerRegistrationData {

  String fName;
  String lName;
  String email;
  String phone;
  String password;
  String shopName;
  String shopAddress;
  int commercialDocument;
  String crIDNo;

  String imagePath;
  String crFreelanceDocPath;
  String logoPath;
  String bannerPath;
  String additionalLegalDocPath;

  SellerRegistrationData({
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.password,
    required this.shopName,
    required this.shopAddress,
    required this.commercialDocument,
    required this.crIDNo,
    required this.crFreelanceDocPath,
    required this.imagePath,
    required this.logoPath,
    required this.bannerPath,
    required this.additionalLegalDocPath,
  });

  //to map
  Map<String, dynamic> toMap() {
    return {
      'f_name': fName,
      'l_name': lName,
      'email': email,
      'phone': phone,
      'password': password,
      'shop_name': shopName,
      'shop_address': shopAddress,
      'commercial_document': commercialDocument,
      'cr_id_no': crIDNo,
    };
  }

}