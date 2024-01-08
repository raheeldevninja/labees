class CheckoutSettings {
  int? billingInputByCustomer;
  int? productTax;

  bool? success;
  String? message;

  CheckoutSettings({this.billingInputByCustomer, this.productTax, this.success, this.message});

  CheckoutSettings.fromJson(Map<String, dynamic> json) {
    billingInputByCustomer = json['billing_input_by_customer'];
    productTax = json['product_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['billing_input_by_customer'] = this.billingInputByCustomer;
    data['product_tax'] = this.productTax;
    return data;
  }
}
