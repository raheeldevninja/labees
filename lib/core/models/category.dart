class Category {
  final String name;
  final bool isSelected;
  final String? image;

  Category({
    required this.name,
    this.isSelected = false,
    this.image,
  });

  Category copyWith({String? name, bool? isSelected}) {
    return Category(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      image: image ?? this.image,
    );
  }
}
