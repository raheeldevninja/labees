class ProductSizes {
  final String size;
  final bool isSelected;

  ProductSizes({required this.size, this.isSelected = false});

  ProductSizes copyWith({String? size, bool? isSelected}) {
    return ProductSizes(
      size: size ?? this.size,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
