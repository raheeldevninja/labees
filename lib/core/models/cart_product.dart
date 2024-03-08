import 'package:labees/core/models/cart_choices.dart';

class CartProduct {
  final int id;
  final String title;
  final String brand;
  final int quantity;
  final int totalPrice;
  final int unitPrice;
  final String image;
  final String slug;
  final int currentSock;
  final String choiceString;

  final List<CartChoices> choices;

  CartProduct({
    required this.id,
    required this.title,
    required this.brand,
    required this.quantity,
    required this.totalPrice,
    required this.unitPrice,
    required this.image,
    required this.slug,
    required this.currentSock,
    required this.choiceString,
    required this.choices,
  });

  CartProduct copyWith({
    int? id,
    String? title,
    String? brand,
    int? quantity,
    int? totalPrice,
    int? unitPrice,
    String? image,
    String? slug,
    int? currentSock,
    String? choiceString,
    List<CartChoices>? choices,
  }) {
    return CartProduct(
      id: id ?? this.id,
      title: title ?? this.title,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      unitPrice: unitPrice ?? this.unitPrice,
      image: image ?? this.image,
      slug: slug ?? this.slug,
      currentSock: currentSock ?? this.currentSock,
      choiceString: choiceString ?? this.choiceString,
      choices: choices ?? this.choices,
    );
  }

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      title: json['title'],
      brand: json['brand'],
      quantity: json['qty'],
      totalPrice: json['price'],
      unitPrice: json['unitPrice'],
      image: json['image'],
      slug: json['slug'],
      currentSock: json['current_stock'],
      choiceString: json['choice_str'],
      choices: List<CartChoices>.from(
          json['choices'].map((x) => CartChoices.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'brand': brand,
      'qty': quantity,
      'price': totalPrice,
      'unitPrice': unitPrice,
      'image': image,
      'slug': slug,
      'current_stock': currentSock,
      'choice_str': choiceString,
      'choices': choices.map((x) => x.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CartProduct(id: $id, title: $title, brand: $brand, quantity: $quantity, totalPrice: $totalPrice, unitPrice: $unitPrice, image: $image, slug: $slug, currentSock: $currentSock)';
  }
}
