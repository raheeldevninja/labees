import 'package:labees/features/home/models/product.dart';

class SellerProductsResponse {
  int? totalSize;
  int? limit;
  int? offset;
  List<Products>? products;
  int? productTax;

  String? message;
  bool? success;

  SellerProductsResponse(
      {this.totalSize,
        this.limit,
        this.offset,
        this.products,
        this.productTax,
        this.message,
        this.success,
      });

  SellerProductsResponse.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    productTax = json['product_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['product_tax'] = this.productTax;
    return data;
  }
}
