class PriceRange {
  int? lowestPrice;
  int? highestPrice;

  PriceRange({this.lowestPrice, this.highestPrice});

  PriceRange.fromJson(Map<String, dynamic> json) {
    lowestPrice = json['lowest_price'];
    highestPrice = json['highest_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lowest_price'] = lowestPrice;
    data['highest_price'] = highestPrice;
    return data;
  }
}
