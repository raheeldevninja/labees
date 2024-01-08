class Brand {

  final String name;
  final bool isSelected;
  final String? image;

  Brand({required this.name, this.isSelected=false, this.image});

  Brand copyWith({String? name, bool? isSelected}) {
    return Brand(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      image: image ?? image,
    );
  }


}