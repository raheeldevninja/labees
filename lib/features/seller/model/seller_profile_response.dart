class SellerProfileResponse {
  Seller? seller;
  int? avgRating;
  int? totalReview;
  int? totalOrder;

  String? message;
  bool? success;

  SellerProfileResponse(
      {this.seller, this.avgRating, this.totalReview, this.totalOrder, this.message, this.success});

  SellerProfileResponse.fromJson(Map<String, dynamic> json) {
    seller =
    json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    avgRating = json['avg_rating'];
    totalReview = json['total_review'];
    totalOrder = json['total_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    data['avg_rating'] = this.avgRating;
    data['total_review'] = this.totalReview;
    data['total_order'] = this.totalOrder;
    return data;
  }
}

class Seller {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  Shop? shop;
  List<Orders>? orders;

  Seller(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.shop,
        this.orders});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  int? id;
  int? sellerId;
  String? name;
  String? address;
  String? contact;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? banner;
  int? commercialDocument;
  Null? crIdNo;
  Null? crFreelanceDocument;
  Null? additionalLegalDocument;
  Null? city;

  Shop(
      {this.id,
        this.sellerId,
        this.name,
        this.address,
        this.contact,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.banner,
        this.commercialDocument,
        this.crIdNo,
        this.crFreelanceDocument,
        this.additionalLegalDocument,
        this.city});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
    commercialDocument = json['commercial_document'];
    crIdNo = json['cr_id_no'];
    crFreelanceDocument = json['cr_freelance_document'];
    additionalLegalDocument = json['additional_legal_document'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;
    data['commercial_document'] = this.commercialDocument;
    data['cr_id_no'] = this.crIdNo;
    data['cr_freelance_document'] = this.crFreelanceDocument;
    data['additional_legal_document'] = this.additionalLegalDocument;
    data['city'] = this.city;
    return data;
  }
}

class Orders {
  int? id;
  int? orderRef;
  int? customerId;
  String? customerType;
  String? paymentStatus;
  String? orderStatus;
  String? sellerOrderStatus;
  String? cancelReason;
  String? otherCancelReason;
  String? paymentMethod;
  String? transactionRef;
  double? orderAmount;
  String? adminCommission;
  String? isPause;
  String? cause;
  int? shippingAddress;
  String? createdAt;
  String? updatedAt;
  int? discountAmount;
  String? discountType;
  String? couponCode;
  String? couponDiscountBearer;
  int? shippingMethodId;
  int? shippingCost;
  String? orderGroupId;
  String? verificationCode;
  int? sellerId;
  String? sellerIs;
  Null? deliveryManId;
  int? deliverymanCharge;
  String? expectedDeliveryDate;
  String? orderNote;
  int? billingAddress;
  String? orderType;
  int? extraDiscount;
  Null? extraDiscountType;
  int? checked;
  String? shippingType;
  Null? deliveryType;
  Null? deliveryServiceName;
  Null? thirdPartyDeliveryTrackingId;
  Null? adminId;
  int? isPartiallyPaid;
  int? partiallyPaidAmount;
  int? vat;
  int? vatPerc;
  double? shippingVat;
  String? shippingMethod;
  String? couponType;
  String? couponTitle;
  int? collectionPointId;
  String? shippingAddressData;
  String? billingAddressData;

  Orders(
      {this.id,
        this.orderRef,
        this.customerId,
        this.customerType,
        this.paymentStatus,
        this.orderStatus,
        this.sellerOrderStatus,
        this.cancelReason,
        this.otherCancelReason,
        this.paymentMethod,
        this.transactionRef,
        this.orderAmount,
        this.adminCommission,
        this.isPause,
        this.cause,
        this.shippingAddress,
        this.createdAt,
        this.updatedAt,
        this.discountAmount,
        this.discountType,
        this.couponCode,
        this.couponDiscountBearer,
        this.shippingMethodId,
        this.shippingCost,
        this.orderGroupId,
        this.verificationCode,
        this.sellerId,
        this.sellerIs,
        this.deliveryManId,
        this.deliverymanCharge,
        this.expectedDeliveryDate,
        this.orderNote,
        this.billingAddress,
        this.orderType,
        this.extraDiscount,
        this.extraDiscountType,
        this.checked,
        this.shippingType,
        this.deliveryType,
        this.deliveryServiceName,
        this.thirdPartyDeliveryTrackingId,
        this.adminId,
        this.isPartiallyPaid,
        this.partiallyPaidAmount,
        this.vat,
        this.vatPerc,
        this.shippingVat,
        this.shippingMethod,
        this.couponType,
        this.couponTitle,
        this.collectionPointId,
        this.shippingAddressData,
        this.billingAddressData});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderRef = json['order_ref'];
    customerId = json['customer_id'];
    customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    sellerOrderStatus = json['seller_order_status'];
    cancelReason = json['cancel_reason'];
    otherCancelReason = json['other_cancel_reason'];
    paymentMethod = json['payment_method'];
    transactionRef = json['transaction_ref'];
    orderAmount = json['order_amount'].toDouble();
    adminCommission = json['admin_commission'];
    isPause = json['is_pause'];
    cause = json['cause'];
    shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discountAmount = json['discount_amount'];
    discountType = json['discount_type'];
    couponCode = json['coupon_code'];
    couponDiscountBearer = json['coupon_discount_bearer'];
    shippingMethodId = json['shipping_method_id'];
    shippingCost = json['shipping_cost'];
    orderGroupId = json['order_group_id'];
    verificationCode = json['verification_code'];
    sellerId = json['seller_id'];
    sellerIs = json['seller_is'];
    deliveryManId = json['delivery_man_id'];
    deliverymanCharge = json['deliveryman_charge'];
    expectedDeliveryDate = json['expected_delivery_date'];
    orderNote = json['order_note'];
    billingAddress = json['billing_address'];
    orderType = json['order_type'];
    extraDiscount = json['extra_discount'];
    extraDiscountType = json['extra_discount_type'];
    checked = json['checked'];
    shippingType = json['shipping_type'];
    deliveryType = json['delivery_type'];
    deliveryServiceName = json['delivery_service_name'];
    thirdPartyDeliveryTrackingId = json['third_party_delivery_tracking_id'];
    adminId = json['admin_id'];
    isPartiallyPaid = json['is_partially_paid'];
    partiallyPaidAmount = json['partially_paid_amount'];
    vat = json['vat'];
    vatPerc = json['vat_perc'];
    shippingVat = json['shipping_vat'].toDouble();
    shippingMethod = json['shipping_method'];
    couponType = json['coupon_type'];
    couponTitle = json['coupon_title'];
    collectionPointId = json['collection_point_id'];
    shippingAddressData = json['shipping_address_data'];
    billingAddressData = json['billing_address_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_ref'] = this.orderRef;
    data['customer_id'] = this.customerId;
    data['customer_type'] = this.customerType;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['seller_order_status'] = this.sellerOrderStatus;
    data['cancel_reason'] = this.cancelReason;
    data['other_cancel_reason'] = this.otherCancelReason;
    data['payment_method'] = this.paymentMethod;
    data['transaction_ref'] = this.transactionRef;
    data['order_amount'] = this.orderAmount;
    data['admin_commission'] = this.adminCommission;
    data['is_pause'] = this.isPause;
    data['cause'] = this.cause;
    data['shipping_address'] = this.shippingAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['discount_amount'] = this.discountAmount;
    data['discount_type'] = this.discountType;
    data['coupon_code'] = this.couponCode;
    data['coupon_discount_bearer'] = this.couponDiscountBearer;
    data['shipping_method_id'] = this.shippingMethodId;
    data['shipping_cost'] = this.shippingCost;
    data['order_group_id'] = this.orderGroupId;
    data['verification_code'] = this.verificationCode;
    data['seller_id'] = this.sellerId;
    data['seller_is'] = this.sellerIs;
    data['delivery_man_id'] = this.deliveryManId;
    data['deliveryman_charge'] = this.deliverymanCharge;
    data['expected_delivery_date'] = this.expectedDeliveryDate;
    data['order_note'] = this.orderNote;
    data['billing_address'] = this.billingAddress;
    data['order_type'] = this.orderType;
    data['extra_discount'] = this.extraDiscount;
    data['extra_discount_type'] = this.extraDiscountType;
    data['checked'] = this.checked;
    data['shipping_type'] = this.shippingType;
    data['delivery_type'] = this.deliveryType;
    data['delivery_service_name'] = this.deliveryServiceName;
    data['third_party_delivery_tracking_id'] =
        this.thirdPartyDeliveryTrackingId;
    data['admin_id'] = this.adminId;
    data['is_partially_paid'] = this.isPartiallyPaid;
    data['partially_paid_amount'] = this.partiallyPaidAmount;
    data['vat'] = this.vat;
    data['vat_perc'] = this.vatPerc;
    data['shipping_vat'] = this.shippingVat;
    data['shipping_method'] = this.shippingMethod;
    data['coupon_type'] = this.couponType;
    data['coupon_title'] = this.couponTitle;
    data['collection_point_id'] = this.collectionPointId;
    data['shipping_address_data'] = this.shippingAddressData;
    data['billing_address_data'] = this.billingAddressData;
    return data;
  }
}
