import 'package:labees/features/home/models/product.dart';

class GetWishlist {
  int? id;
  int? customerId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Products? product;

  bool? success;
  String? message;

  GetWishlist(
      {this.id,
        this.customerId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.success,
        this.message
      });

  GetWishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Products.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
