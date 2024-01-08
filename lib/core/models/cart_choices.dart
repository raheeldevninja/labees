class CartChoices {

  final int id;
  final String attributeChoice;
  final int attributeId;
  final String attributeName;
  final String name;

  CartChoices({
    required this.id,
    required this.attributeChoice,
    required this.attributeId,
    required this.attributeName,
    required this.name,
  });

  CartChoices copyWith({
    int? id,
    String? attributeChoice,
    int? attributeId,
    String? attributeName,
    String? name,
  }) {
    return CartChoices(
      id: id ?? this.id,
      attributeChoice: attributeChoice ?? this.attributeChoice,
      attributeId: attributeId ?? this.attributeId,
      attributeName: attributeName ?? this.attributeName,
      name: name ?? this.name,
    );
  }

  factory CartChoices.fromJson(Map<String, dynamic> json) {
    return CartChoices(
      id: json['id'],
      attributeChoice: json['attribute_choice'],
      attributeId: json['attribute_id'],
      attributeName: json['attribute_name'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attribute_choice': attributeChoice,
      'attribute_id': attributeId,
      'attribute_name': attributeName,
      'name': name,
    };
  }


}