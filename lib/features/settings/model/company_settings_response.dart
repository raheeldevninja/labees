class CompanySettingsResponse {
  String? companyPhone;
  String? companyEmail;

  String? message;
  bool? success;

  CompanySettingsResponse({this.companyPhone, this.companyEmail, this.message, this.success});

  CompanySettingsResponse.fromJson(Map<String, dynamic> json) {
    companyPhone = json['company_phone'];
    companyEmail = json['company_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['company_phone'] = this.companyPhone;
    data['company_email'] = this.companyEmail;
    return data;
  }
}
