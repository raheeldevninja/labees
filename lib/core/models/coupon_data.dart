class CouponData {
  String? code;
  int? discount;


  CouponData({
    this.code,
    this.discount,
  });

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      code: json['code'],
      discount: json['discount'],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['discount'] = this.discount;
    return data;
  }

}