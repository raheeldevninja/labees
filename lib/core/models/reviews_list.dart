import '../../features/products/model/customer.dart';

class ReviewsList {
  int? id;
  int? productId;
  int? customerId;
  String? deliveryManId;
  String? orderId;
  String? comment;
  String? attachment;
  int? rating;
  int? status;
  int? isSaved;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  ReviewsList(
      {this.id,
      this.productId,
      this.customerId,
      this.deliveryManId,
      this.orderId,
      this.comment,
      this.attachment,
      this.rating,
      this.status,
      this.isSaved,
      this.createdAt,
      this.updatedAt,
      this.customer});

  ReviewsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    deliveryManId = json['delivery_man_id'];
    orderId = json['order_id'];
    comment = json['comment'];
    attachment = json['attachment'];
    rating = json['rating'];
    status = json['status'];
    isSaved = json['is_saved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['delivery_man_id'] = this.deliveryManId;
    data['order_id'] = this.orderId;
    data['comment'] = this.comment;
    data['attachment'] = this.attachment;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['is_saved'] = this.isSaved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}
