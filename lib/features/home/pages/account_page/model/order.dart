import 'package:labees/features/home/pages/account_page/model/order_product.dart';

class Order {
  final String orderStatus;
  final String paymentStatus;
  final String shippingStatus;
  final List<OrderProduct> products;
  final double totalPrice;
  final String paymentMethod;

  Order({
    required this.orderStatus,
    required this.paymentStatus,
    required this.shippingStatus,
    required this.products,
    required this.totalPrice,
    required this.paymentMethod,
  });

  Order copyWith({
    String? orderStatus,
    String? paymentStatus,
    String? shippingStatus,
    List<OrderProduct>? products,
    double? totalPrice,
    String? paymentMethod,
  }) {
    return Order(
      orderStatus: orderStatus ?? this.orderStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      shippingStatus: shippingStatus ?? this.shippingStatus,
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
