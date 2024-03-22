import 'dart:convert';

import 'package:labees/core/models/cart_product.dart';

class PlaceOrderModel {
  List<CartProduct>? cartProducts;
  final int? addressId;
  final int? billingAddressId;
  final String? paymentMethod;
  final int? shippingMethod;
  final int? isPartiallyPaid;
  final int? partiallyWalletAmount;
  final String? couponCode;
  final int? couponDiscount;
  final int? vat;
  final int? vatPrice;

  final String? transactionId;
  final String? lastFourDigits;

  PlaceOrderModel({
    this.cartProducts,
    this.addressId,
    this.billingAddressId,
    this.paymentMethod,
    this.shippingMethod,
    this.isPartiallyPaid,
    this.partiallyWalletAmount,
    this.couponCode,
    this.couponDiscount,
    this.vat,
    this.vatPrice,
    this.transactionId,
    this.lastFourDigits,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderModel(
      cartProducts: json['cart_data'] != null
          ? (json['cart_data'] as List)
              .map((i) => CartProduct.fromJson(i))
              .toList()
          : null,
      addressId: json['address_id'],
      billingAddressId: json['billing_address_id'],
      paymentMethod: json['payment_method'],
      shippingMethod: json['shipping_method'],
      isPartiallyPaid: json['is_partially_paid'],
      partiallyWalletAmount: json['partially_wallet_amount'],
      couponCode: json['coupon_code'],
      couponDiscount: json['coupon_discount'],
      vat: json['vat'],
      vatPrice: json['vat_perc'],
      transactionId: json['transaction_id'],
      lastFourDigits: json['last_four_digits'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_data': cartProducts != null
          ? jsonEncode(cartProducts!.map((i) => i.toJson()).toList())
          : null,
      'address_id': addressId,
      'billing_address_id': billingAddressId,
      'payment_method': paymentMethod,
      'shipping_method': shippingMethod,
      'is_partially_paid': isPartiallyPaid,
      'partially_wallet_amount': partiallyWalletAmount,
      'coupon_code': couponCode,
      'coupon_discount': couponDiscount,
      'vat': vat,
      'vat_perc': vatPrice,
      'shipping_vat': 2.5,
      'transaction_id': transactionId,
      'last_four_digits': lastFourDigits,
    };
  }

  PlaceOrderModel copyWith({
    List<CartProduct>? cartProducts,
    int? addressId,
    int? billingAddressId,
    String? paymentMethod,
    int? shippingMethod,
    int? isPartiallyPaid,
    int? partiallyWalletAmount,
    String? couponCode,
    int? couponDiscount,
    int? vat,
    int? vatPrice,
    String? transactionId,
    String? lastFourDigits,
  }) {
    return PlaceOrderModel(
      cartProducts: cartProducts ?? cartProducts,
      addressId: addressId ?? this.addressId,
      billingAddressId: billingAddressId ?? this.billingAddressId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      isPartiallyPaid: isPartiallyPaid ?? this.isPartiallyPaid,
      partiallyWalletAmount:
          partiallyWalletAmount ?? this.partiallyWalletAmount,
      couponCode: couponCode ?? this.couponCode,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      vat: vat ?? this.vat,
      vatPrice: vatPrice ?? this.vatPrice,
      transactionId: transactionId ?? this.transactionId,
      lastFourDigits: lastFourDigits ?? this.lastFourDigits,
    );
  }
}
