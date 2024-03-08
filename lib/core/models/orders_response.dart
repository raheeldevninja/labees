import 'package:labees/core/models/links.dart';
import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/models/category_ids.dart';
import 'package:labees/features/home/models/choice_option.dart';
import 'package:labees/features/home/models/review.dart';
import 'package:labees/features/home/models/variation.dart';

class OrdersResponse {
  int? currentPage;
  List<OrderData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  bool? success;
  String? message;

  OrdersResponse(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total,
      this.success,
      this.message});

  OrdersResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(new OrderData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class OrderData {
  int? id;
  int? customerId;
  String? customerType;
  String? paymentStatus;
  String? orderStatus;
  String? cancelReason;
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
  BillingAddressData? shippingAddressData;
  Null? deliveryManId;
  int? deliverymanCharge;
  String? expectedDeliveryDate;
  String? orderNote;
  int? billingAddress;
  BillingAddressData? billingAddressData;
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
  double? shippingVAT;
  List<Details>? details;
  Summary? summary;
  Null? deliveryMan;

  OrderData(
      {this.id,
      this.customerId,
      this.customerType,
      this.paymentStatus,
      this.orderStatus,
      this.cancelReason,
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
      this.shippingAddressData,
      this.deliveryManId,
      this.deliverymanCharge,
      this.expectedDeliveryDate,
      this.orderNote,
      this.billingAddress,
      this.billingAddressData,
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
      this.shippingVAT,
      this.details,
      this.summary,
      this.deliveryMan});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    cancelReason = json['cancel_reason'];
    paymentMethod = json['payment_method'];
    transactionRef = json['transaction_ref'];
    orderAmount = json['order_amount']?.toDouble() ?? 0.0;
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
    shippingAddressData = json['shipping_address_data'] != null
        ? new BillingAddressData.fromJson(json['shipping_address_data'])
        : null;

    deliveryManId = json['delivery_man_id'];
    deliverymanCharge = json['deliveryman_charge'];
    expectedDeliveryDate = json['expected_delivery_date'];
    orderNote = json['order_note'];
    billingAddress = json['billing_address'];
    billingAddressData = json['billing_address_data'] != null
        ? new BillingAddressData.fromJson(json['billing_address_data'])
        : null;
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
    shippingVAT = json['shipping_vat']?.toDouble() ?? 0.0;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    deliveryMan = json['delivery_man'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['customer_type'] = this.customerType;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['cancel_reason'] = this.cancelReason;
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
    data['shipping_address_data'] = this.shippingAddressData;
    data['delivery_man_id'] = this.deliveryManId;
    data['deliveryman_charge'] = this.deliverymanCharge;
    data['expected_delivery_date'] = this.expectedDeliveryDate;
    data['order_note'] = this.orderNote;
    data['billing_address'] = this.billingAddress;
    if (this.billingAddressData != null) {
      data['billing_address_data'] = this.billingAddressData!.toJson();
    }
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
    data['shipping_vat'] = this.shippingVAT;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    data['delivery_man'] = this.deliveryMan;
    return data;
  }
}

class BillingAddressData {
  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? phoneCode;
  String? createdAt;
  String? updatedAt;
  Null? state;
  String? country;
  String? latitude;
  String? longitude;
  int? isBilling;
  int? isDefault;

  BillingAddressData(
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

  BillingAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'].toString();
    zip = json['zip'];
    phone = json['phone'];
    phoneCode = json['phone_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'].toString();
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

class Details {
  int? id;
  int? orderId;
  int? productId;
  int? sellerId;
  Null? digitalFileAfterSell;
  ProductDetails? productDetails;
  int? qty;
  int? price;
  int? tax;
  int? discount;
  String? deliveryStatus;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  BillingAddressData? shippingMethodId;
  String? variant;
  //List<Null>? variation;
  String? discountType;
  int? isStockDecreased;
  int? refundRequest;
  Seller? seller;

  Details(
      {this.id,
      this.orderId,
      this.productId,
      this.sellerId,
      this.digitalFileAfterSell,
      this.productDetails,
      this.qty,
      this.price,
      this.tax,
      this.discount,
      this.deliveryStatus,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
      this.shippingMethodId,
      this.variant,
      //this.variation,
      this.discountType,
      this.isStockDecreased,
      this.refundRequest,
      this.seller});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    sellerId = json['seller_id'];
    digitalFileAfterSell = json['digital_file_after_sell'];
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
    qty = json['qty'];
    price = json['price'];
    tax = json['tax'];
    discount = json['discount'];
    deliveryStatus = json['delivery_status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shippingMethodId = json['shipping_method_id'];
    variant = json['variant'];
    /*if (json['variation'] != null) {
      variation = <Null>[];
      json['variation'].forEach((v) {
        variation!.add(Null.fromJson(v));
      });
    }*/
    discountType = json['discount_type'];
    isStockDecreased = json['is_stock_decreased'];
    refundRequest = json['refund_request'];
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['seller_id'] = this.sellerId;
    data['digital_file_after_sell'] = this.digitalFileAfterSell;
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
    }
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['delivery_status'] = this.deliveryStatus;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['shipping_method_id'] = this.shippingMethodId;
    data['variant'] = this.variant;
    /*if (this.variation != null) {
      data['variation'] = this.variation!.map((v) => v.toJson()).toList();
    }*/
    data['discount_type'] = this.discountType;
    data['is_stock_decreased'] = this.isStockDecreased;
    data['refund_request'] = this.refundRequest;
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;
  String? productType;
  List<CategoryIds>? categoryIds;
  String? categories;
  int? brandId;
  String? unit;
  int? minQty;
  int? refundable;
  Null? digitalProductType;
  Null? digitalFileReady;
  List<String>? images;
  String? thumbnail;
  String? hoverThumbnail;
  int? featured;
  Null? flashDeal;
  String? videoProvider;
  Null? videoUrl;
  String? colors;
  String? tags;
  String? similarProducts;
  String? customersAlsoBoughtProducts;
  int? variantProduct;
  List<int>? attributes;
  List<ChoiceOptions>? choiceOptions;
  List<Variation>? variation;
  int? published;
  int? unitPrice;
  int? purchasePrice;
  int? tax;
  String? taxType;
  int? discount;
  String? discountType;
  int? currentStock;
  int? minimumOrderQty;
  String? shortDescription;
  String? details;
  String? sizes;
  int? freeShipping;
  Null? attachment;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? requestStatus;
  Null? deniedNote;
  int? shippingCost;
  int? multiplyQty;
  Null? tempShippingCost;
  Null? isShippingCostUpdated;
  String? code;
  int? qualityScore;
  Null? referenceSku;
  int? reviewsCount;
  List<Reviews>? reviews;
  List<Null>? colorsFormatted;
  Brand? brand;

  ProductDetails(
      {this.id,
      this.addedBy,
      this.userId,
      this.name,
      this.slug,
      this.productType,
      this.categoryIds,
      this.categories,
      this.brandId,
      this.unit,
      this.minQty,
      this.refundable,
      this.digitalProductType,
      this.digitalFileReady,
      this.images,
      this.thumbnail,
      this.hoverThumbnail,
      this.featured,
      this.flashDeal,
      this.videoProvider,
      this.videoUrl,
      this.colors,
      this.tags,
      this.similarProducts,
      this.customersAlsoBoughtProducts,
      this.variantProduct,
      this.attributes,
      this.choiceOptions,
      this.variation,
      this.published,
      this.unitPrice,
      this.purchasePrice,
      this.tax,
      this.taxType,
      this.discount,
      this.discountType,
      this.currentStock,
      this.minimumOrderQty,
      this.shortDescription,
      this.details,
      this.sizes,
      this.freeShipping,
      this.attachment,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.featuredStatus,
      this.metaTitle,
      this.metaDescription,
      this.metaImage,
      this.requestStatus,
      this.deniedNote,
      this.shippingCost,
      this.multiplyQty,
      this.tempShippingCost,
      this.isShippingCostUpdated,
      this.code,
      this.qualityScore,
      this.referenceSku,
      this.reviewsCount,
      this.reviews,
      this.colorsFormatted,
      this.brand});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'];
    slug = json['slug'];
    productType = json['product_type'];
    if (json['category_ids'] != null) {
      categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        categoryIds!.add(CategoryIds.fromJson(v));
      });
    }
    categories = json['categories'];
    brandId = json['brand_id'];
    unit = json['unit'];
    minQty = json['min_qty'];
    refundable = json['refundable'];
    digitalProductType = json['digital_product_type'];
    digitalFileReady = json['digital_file_ready'];
    images = json['images'].cast<String>();
    thumbnail = json['thumbnail'];
    hoverThumbnail = json['hover_thumbnail'];
    featured = json['featured'];
    flashDeal = json['flash_deal'];
    videoProvider = json['video_provider'];
    videoUrl = json['video_url'];
    colors = json['colors'];
    tags = json['tags'];
    similarProducts = json['similar_products'];
    customersAlsoBoughtProducts = json['customers_also_bought_products'];
    variantProduct = json['variant_product'];
    attributes = json['attributes'].cast<int>();
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(Variation.fromJson(v));
      });
    }
    published = json['published'];
    unitPrice = json['unit_price'];
    purchasePrice = json['purchase_price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    currentStock = json['current_stock'];
    minimumOrderQty = json['minimum_order_qty'];
    shortDescription = json['short_description'];
    details = json['details'];
    sizes = json['sizes'];
    freeShipping = json['free_shipping'];
    attachment = json['attachment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    featuredStatus = json['featured_status'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    requestStatus = json['request_status'];
    deniedNote = json['denied_note'];
    shippingCost = json['shipping_cost'];
    multiplyQty = json['multiply_qty'];
    tempShippingCost = json['temp_shipping_cost'];
    isShippingCostUpdated = json['is_shipping_cost_updated'];
    code = json['code'];
    qualityScore = json['quality_score'];
    referenceSku = json['reference_sku'];
    reviewsCount = json['reviews_count'];

    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    /*if (json['colors_formatted'] != null) {
      colorsFormatted = <Null>[];
      json['colors_formatted'].forEach((v) {
        colorsFormatted!.add(new Null.fromJson(v));
      });
    }*/
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['product_type'] = this.productType;
    if (this.categoryIds != null) {
      data['category_ids'] = this.categoryIds!.map((v) => v.toJson()).toList();
    }
    data['categories'] = this.categories;
    data['brand_id'] = this.brandId;
    data['unit'] = this.unit;
    data['min_qty'] = this.minQty;
    data['refundable'] = this.refundable;
    data['digital_product_type'] = this.digitalProductType;
    data['digital_file_ready'] = this.digitalFileReady;
    data['images'] = this.images;
    data['thumbnail'] = this.thumbnail;
    data['hover_thumbnail'] = this.hoverThumbnail;
    data['featured'] = this.featured;
    data['flash_deal'] = this.flashDeal;
    data['video_provider'] = this.videoProvider;
    data['video_url'] = this.videoUrl;
    data['colors'] = this.colors;
    data['tags'] = this.tags;
    data['similar_products'] = this.similarProducts;
    data['customers_also_bought_products'] = this.customersAlsoBoughtProducts;
    data['variant_product'] = this.variantProduct;
    data['attributes'] = this.attributes;
    if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (this.variation != null) {
      data['variation'] = this.variation!.map((v) => v.toJson()).toList();
    }
    data['published'] = this.published;
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['current_stock'] = this.currentStock;
    data['minimum_order_qty'] = this.minimumOrderQty;
    data['short_description'] = this.shortDescription;
    data['details'] = this.details;
    data['sizes'] = this.sizes;
    data['free_shipping'] = this.freeShipping;
    data['attachment'] = this.attachment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['featured_status'] = this.featuredStatus;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_image'] = this.metaImage;
    data['request_status'] = this.requestStatus;
    data['denied_note'] = this.deniedNote;
    data['shipping_cost'] = this.shippingCost;
    data['multiply_qty'] = this.multiplyQty;
    data['temp_shipping_cost'] = this.tempShippingCost;
    data['is_shipping_cost_updated'] = this.isShippingCostUpdated;
    data['code'] = this.code;
    data['quality_score'] = this.qualityScore;
    data['reference_sku'] = this.referenceSku;
    data['reviews_count'] = this.reviewsCount;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    /*if (this.colorsFormatted != null) {
      data['colors_formatted'] =
          this.colorsFormatted!.map((v) => v.toJson()).toList();
    }*/
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    return data;
  }
}

class Seller {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? password;
  String? status;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? bankName;
  String? branch;
  String? accountNo;
  String? holderName;
  String? authToken;
  Null? salesCommissionPercentage;
  Null? gst;
  Null? cmFirebaseToken;
  int? posStatus;
  int? adminId;
  Null? sellerRoleId;
  Null? parentId;
  Shop? shop;

  Seller(
      {this.id,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      this.password,
      this.status,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.bankName,
      this.branch,
      this.accountNo,
      this.holderName,
      this.authToken,
      this.salesCommissionPercentage,
      this.gst,
      this.cmFirebaseToken,
      this.posStatus,
      this.adminId,
      this.sellerRoleId,
      this.parentId,
      this.shop});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
    authToken = json['auth_token'];
    salesCommissionPercentage = json['sales_commission_percentage'];
    gst = json['gst'];
    cmFirebaseToken = json['cm_firebase_token'];
    posStatus = json['pos_status'];
    adminId = json['admin_id'];
    sellerRoleId = json['seller_role_id'];
    parentId = json['parent_id'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bank_name'] = this.bankName;
    data['branch'] = this.branch;
    data['account_no'] = this.accountNo;
    data['holder_name'] = this.holderName;
    data['auth_token'] = this.authToken;
    data['sales_commission_percentage'] = this.salesCommissionPercentage;
    data['gst'] = this.gst;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['pos_status'] = this.posStatus;
    data['admin_id'] = this.adminId;
    data['seller_role_id'] = this.sellerRoleId;
    data['parent_id'] = this.parentId;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
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
      this.additionalLegalDocument});

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
    return data;
  }
}

class Summary {
  int? subtotal;
  int? totalTax;
  int? totalDiscountOnProduct;
  int? totalShippingCost;

  Summary(
      {this.subtotal,
      this.totalTax,
      this.totalDiscountOnProduct,
      this.totalShippingCost});

  Summary.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    totalTax = json['total_tax'];
    totalDiscountOnProduct = json['total_discount_on_product'];
    totalShippingCost = json['total_shipping_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['total_tax'] = this.totalTax;
    data['total_discount_on_product'] = this.totalDiscountOnProduct;
    data['total_shipping_cost'] = this.totalShippingCost;
    return data;
  }
}
