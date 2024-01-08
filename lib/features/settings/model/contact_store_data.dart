class ContactStoreData {

  int inquiryType;
  String name;
  String email;
  String mobileNumber;
  String subject;
  String message;

  ContactStoreData({
    required this.inquiryType,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.subject,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['inquiry_type'] = this.inquiryType;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['subject'] = this.subject;
    data['message'] = this.message;
    return data;
  }


}