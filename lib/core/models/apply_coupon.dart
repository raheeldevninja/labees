class ApplyCoupon {
  Data? data;

  bool? success;
  String? message;

  ApplyCoupon({this.data, this.success, this.message});

  ApplyCoupon.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Coupon? coupon;
  int? couponDiscount;

  Data({this.coupon, this.couponDiscount});

  Data.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
    couponDiscount = json['coupon_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.coupon != null) {
      data['coupon'] = this.coupon!.toJson();
    }
    data['coupon_discount'] = this.couponDiscount;
    return data;
  }
}

class Coupon {
  int? id;
  String? addedBy;
  String? couponType;
  String? couponBearer;
  int? sellerId;
  int? customerId;
  int? customerGroupId;
  String? title;
  String? code;
  String? startDate;
  String? expireDate;
  int? minPurchase;
  int? maxDiscount;
  int? discount;
  String? discountType;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? limit;

  Coupon(
      {this.id,
      this.addedBy,
      this.couponType,
      this.couponBearer,
      this.sellerId,
      this.customerId,
      this.customerGroupId,
      this.title,
      this.code,
      this.startDate,
      this.expireDate,
      this.minPurchase,
      this.maxDiscount,
      this.discount,
      this.discountType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.limit});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    couponType = json['coupon_type'];
    couponBearer = json['coupon_bearer'];
    sellerId = json['seller_id'];
    customerId = json['customer_id'];
    customerGroupId = json['customer_group_id'];
    title = json['title'];
    code = json['code'];
    startDate = json['start_date'];
    expireDate = json['expire_date'];
    minPurchase = json['min_purchase'];
    maxDiscount = json['max_discount'];
    discount = json['discount'];
    discountType = json['discount_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['coupon_type'] = this.couponType;
    data['coupon_bearer'] = this.couponBearer;
    data['seller_id'] = this.sellerId;
    data['customer_id'] = this.customerId;
    data['customer_group_id'] = this.customerGroupId;
    data['title'] = this.title;
    data['code'] = this.code;
    data['start_date'] = this.startDate;
    data['expire_date'] = this.expireDate;
    data['min_purchase'] = this.minPurchase;
    data['max_discount'] = this.maxDiscount;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['limit'] = this.limit;
    return data;
  }
}
