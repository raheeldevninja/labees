import 'package:labees/features/products/model/shop.dart';

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

