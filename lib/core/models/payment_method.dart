class PaymentMethod {
  String name;
  String image;
  bool isSelected;

  PaymentMethod({
    required this.name,
    required this.image,
    this.isSelected = false,
  });
}
