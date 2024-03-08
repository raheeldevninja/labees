class MyBag {
  final String productBrand;
  final double price;
  final String productImage;
  final String size;
  final String color;
  final int quantity;

  MyBag(
      {required this.productBrand,
      required this.price,
      required this.productImage,
      required this.size,
      required this.color,
      this.quantity = 1});

  MyBag copyWith({
    String? productBrand,
    String? productName,
    double? price,
    String? productImage,
    String? size,
    String? color,
    int? quantity,
  }) {
    return MyBag(
      productBrand: productBrand ?? this.productBrand,
      price: price ?? this.price,
      productImage: productImage ?? this.productImage,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
    );
  }
}
