import 'package:labees/features/home/models/wish_list.dart';

class WishListRemoveResponse {
  Wishlist? wishlist;
  int? wishlistCount;
  String? message;
  bool? success;

  WishListRemoveResponse(
      {this.wishlist, this.wishlistCount, this.message, this.success});

  WishListRemoveResponse.fromJson(Map<String, dynamic> json) {
    wishlist = json['wishlist'];
    wishlistCount = json['wishlist_count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wishlist'] = this.wishlist;
    data['wishlist_count'] = this.wishlistCount;
    data['message'] = this.message;
    return data;
  }
}
