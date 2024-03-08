import 'package:labees/features/home/models/get_wishlist.dart';

class AllWishlistProducts {
  bool? success;
  String? message;
  List<GetWishlist>? wishlistProducts;

  AllWishlistProducts({this.success, this.message, this.wishlistProducts});
}
