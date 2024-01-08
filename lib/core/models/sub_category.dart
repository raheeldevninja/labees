class SubCategory {
  final String name;
  final bool isSelected;

  SubCategory({
    required this.name,
    this.isSelected = false,
  });

  SubCategory copyWith({String? name, bool? isSelected}) {
    return SubCategory(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
