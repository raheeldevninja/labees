class FilterData {

  String? minAmount;
  String? maxAmount;
  List<int>? subCategories;
  List<int>? brandFilters;
  List<int>? tagsFilters;
  List<int>? attributeValues;

  FilterData({
    this.minAmount,
    this.maxAmount,
    this.subCategories,
    this.brandFilters,
    this.tagsFilters,
    this.attributeValues,
  });

  FilterData copyWith({
    String? minAmount,
    String? maxAmount,
    List<int>? subCategories,
    List<int>? brandFilters,
    List<int>? tagsFilters,
    List<int>? attributeValues,
  }) {
    return FilterData(
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      subCategories: subCategories ?? this.subCategories,
      brandFilters: brandFilters ?? this.brandFilters,
      tagsFilters: tagsFilters ?? this.tagsFilters,
      attributeValues: attributeValues ?? this.attributeValues,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'minAmount': minAmount,
      'maxAmount': maxAmount,
      'subCategories': subCategories,
      'brandFilters': brandFilters,
      'tagsFilters': tagsFilters,
      'attributeValues': attributeValues,
    };
  }

  //to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();


    if(minAmount != null) {
      data['minAmount'] = minAmount;
    }
    if(maxAmount != null) {
      data['maxAmount'] = maxAmount;
    }
    if(subCategories != null) {
      data['subCategories'] = subCategories;
    }
    if(brandFilters != null) {
      data['brandFilters'] = brandFilters;
    }
    if(tagsFilters != null) {
      data['tagsFilters'] = tagsFilters;
    }
    if(attributeValues != null) {
      data['attributeValues'] = attributeValues;
    }

    return data;
  }

}