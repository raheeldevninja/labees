class OrderProduct {

  final String productBrand;
  final String productName;
  final String productImg;
  final double price;
  final String orderId;
  final String size;
  final int quantity;
  final String color;
  final String orderDate;
  final String deliveryDate;

  OrderProduct({
    required this.productBrand,
    required this.productName,
    required this.productImg,
    required this.price,
    required this.orderId,
    required this.size,
    required this.quantity,
    required this.color,
    required this.orderDate,
    required this.deliveryDate
  });

  OrderProduct copyWith({
    String? productBrand,
    String? productName,
    String? productImg,
    double? price,
    String? orderId,
    String? size,
    int? quantity,
    String? color,
    String? orderDate,
    String? deliveryDate
  }) {
    return OrderProduct(
      productBrand: productBrand ?? this.productBrand,
      productName: productName ?? this.productName,
      productImg: productImg ?? this.productImg,
      price: price ?? this.price,
      orderId: orderId ?? this.orderId,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate
    );
  }

}