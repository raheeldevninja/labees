class Shop {
  int? id;
  int? sellerId;
  String? name;
  String? address;
  String? contact;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? banner;
  int? commercialDocument;
  Null? crIdNo;
  Null? crFreelanceDocument;
  Null? additionalLegalDocument;
  Null? city;

  Shop(
      {this.id,
      this.sellerId,
      this.name,
      this.address,
      this.contact,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.banner,
      this.commercialDocument,
      this.crIdNo,
      this.crFreelanceDocument,
      this.additionalLegalDocument,
      this.city});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
    commercialDocument = json['commercial_document'];
    crIdNo = json['cr_id_no'];
    crFreelanceDocument = json['cr_freelance_document'];
    additionalLegalDocument = json['additional_legal_document'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;
    data['commercial_document'] = this.commercialDocument;
    data['cr_id_no'] = this.crIdNo;
    data['cr_freelance_document'] = this.crFreelanceDocument;
    data['additional_legal_document'] = this.additionalLegalDocument;
    data['city'] = this.city;
    return data;
  }
}
