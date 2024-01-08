class User {
  int? id;
  String? name;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Null? streetAddress;
  Null? country;
  Null? city;
  Null? zip;
  Null? houseNo;
  Null? apartmentNo;
  Null? cmFirebaseToken;
  int? isActive;
  Null? paymentCardLastFour;
  Null? paymentCardBrand;
  Null? paymentCardFawryToken;
  Null? loginMedium;
  Null? socialId;
  int? isPhoneVerified;
  String? temporaryToken;
  int? isEmailVerified;
  int? walletBalance;
  int? loyaltyPoint;
  String? lastSeen;
  int? customerGroup;
  String? gender;
  int? newsletter;
  String? defaultLanguage;

  bool? success;
  String? message;

  User(
      {this.id,
        this.name,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.streetAddress,
        this.country,
        this.city,
        this.zip,
        this.houseNo,
        this.apartmentNo,
        this.cmFirebaseToken,
        this.isActive,
        this.paymentCardLastFour,
        this.paymentCardBrand,
        this.paymentCardFawryToken,
        this.loginMedium,
        this.socialId,
        this.isPhoneVerified,
        this.temporaryToken,
        this.isEmailVerified,
        this.walletBalance,
        this.loyaltyPoint,
        this.lastSeen,
        this.customerGroup,
        this.gender,
        this.newsletter,
        this.defaultLanguage,
        this.success = false,
        this.message
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    streetAddress = json['street_address'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    houseNo = json['house_no'];
    apartmentNo = json['apartment_no'];
    cmFirebaseToken = json['cm_firebase_token'];
    isActive = json['is_active'];
    paymentCardLastFour = json['payment_card_last_four'];
    paymentCardBrand = json['payment_card_brand'];
    paymentCardFawryToken = json['payment_card_fawry_token'];
    loginMedium = json['login_medium'];
    socialId = json['social_id'];
    isPhoneVerified = json['is_phone_verified'];
    temporaryToken = json['temporary_token'];
    isEmailVerified = json['is_email_verified'];
    walletBalance = json['wallet_balance'];
    loyaltyPoint = json['loyalty_point'];
    lastSeen = json['last_seen'];
    customerGroup = json['customer_group'];
    gender = json['gender'];
    newsletter = json['newsletter'];
    defaultLanguage = json['default_language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['street_address'] = this.streetAddress;
    data['country'] = this.country;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['house_no'] = this.houseNo;
    data['apartment_no'] = this.apartmentNo;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['is_active'] = this.isActive;
    data['payment_card_last_four'] = this.paymentCardLastFour;
    data['payment_card_brand'] = this.paymentCardBrand;
    data['payment_card_fawry_token'] = this.paymentCardFawryToken;
    data['login_medium'] = this.loginMedium;
    data['social_id'] = this.socialId;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['temporary_token'] = this.temporaryToken;
    data['is_email_verified'] = this.isEmailVerified;
    data['wallet_balance'] = this.walletBalance;
    data['loyalty_point'] = this.loyaltyPoint;
    data['last_seen'] = this.lastSeen;
    data['customer_group'] = this.customerGroup;
    data['gender'] = this.gender;
    data['newsletter'] = this.newsletter;
    data['default_language'] = this.defaultLanguage;
    return data;
  }
}
