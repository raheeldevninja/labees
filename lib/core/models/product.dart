class Product {
  final String productBrand;
  final String productName;
  final double price;
  final String productImage;
  final bool isFavorite;

  Product(
      {required this.productBrand,
      required this.productName,
      required this.price,
      required this.productImage,
      this.isFavorite = false});

  Product copyWith({
    String? productBrand,
    String? productName,
    double? price,
    String? productImage,
    bool? isFavorite,
  }) {
    return Product(
      productBrand: productBrand ?? this.productBrand,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      productImage: productImage ?? this.productImage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
