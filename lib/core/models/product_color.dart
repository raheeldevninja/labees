import 'package:flutter/material.dart';

class ProductColor {
  final Color color;
  final bool isSelected;

  ProductColor({required this.color, this.isSelected = false});

  ProductColor copyWith({Color? color, bool? isSelected}) {
    return ProductColor(
      color: color ?? this.color,
      isSelected: isSelected ?? this.isSelected,
    );
  }

}