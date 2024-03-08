class Transaction {
  final String productName;
  final String brand;
  final double price;
  final String paymentStatus;
  final double discount;
  final String image;
  final String transactionType;

  Transaction(
      {required this.productName,
      required this.brand,
      required this.price,
      required this.paymentStatus,
      required this.discount,
      required this.image,
      required this.transactionType});

  Transaction copyWith(
      {String? productName,
      String? brand,
      double? price,
      String? paymentStatus,
      double? discount,
      String? image,
      String? transactionType}) {
    return Transaction(
        productName: productName ?? this.productName,
        brand: brand ?? this.brand,
        price: price ?? this.price,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        discount: discount ?? this.discount,
        image: image ?? this.image,
        transactionType: transactionType ?? this.transactionType);
  }
}
