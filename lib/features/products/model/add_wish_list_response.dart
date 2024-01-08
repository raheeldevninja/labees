import 'package:labees/features/home/models/wish_list.dart';

class AddWishListResponse {
  Wishlist? wishlist;
  int? wishlistCount;
  String? message;
  bool? success;

  AddWishListResponse({this.wishlist, this.wishlistCount, this.message, this.success});

  AddWishListResponse.fromJson(Map<String, dynamic> json) {
    wishlist = json['wishlist'] != null
        ?  Wishlist.fromJson(json['wishlist'])
        : null;
    wishlistCount = json['wishlist_count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.toJson();
    }
    data['wishlist_count'] = this.wishlistCount;
    data['message'] = this.message;
    return data;
  }
}
