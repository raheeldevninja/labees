class Variation {
  String? attributeValueId;
  String? type;
  var price;
  String? sku;
  int? qty;
  String? image;

  Variation(
      {this.attributeValueId,
      this.type,
      this.price,
      this.sku,
      this.qty,
      this.image});

  Variation.fromJson(Map<String, dynamic> json) {
    attributeValueId = json['attribute_value_id'];
    type = json['type'];
    price = json['price'];
    sku = json['sku'];
    qty = json['qty'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_value_id'] = this.attributeValueId;
    data['type'] = this.type;
    data['price'] = this.price;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    data['image'] = this.image;
    return data;
  }
}
