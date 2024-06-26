class Wishlist {
  int? id;
  int? customerId;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Wishlist(
      {this.id,
      this.customerId,
      this.productId,
      this.createdAt,
      this.updatedAt});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
