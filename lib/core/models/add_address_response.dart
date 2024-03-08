import 'package:labees/core/models/address_data.dart';

class AddAddressResponse {
  int? addressId;
  List<AddressData>? billingAddresses;
  List<AddressData>? shippingAddresses;
  String? message;

  bool? success;

  AddAddressResponse(
      {this.addressId,
      this.billingAddresses,
      this.shippingAddresses,
      this.message,
      this.success});

  AddAddressResponse.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    if (json['billing_addresses'] != null) {
      billingAddresses = <AddressData>[];
      json['billing_addresses'].forEach((v) {
        billingAddresses!.add(AddressData.fromJson(v));
      });
    }
    if (json['shipping_addresses'] != null) {
      shippingAddresses = <AddressData>[];
      json['shipping_addresses'].forEach((v) {
        shippingAddresses!.add(AddressData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address_id'] = this.addressId;
    if (this.billingAddresses != null) {
      data['billing_addresses'] =
          this.billingAddresses!.map((v) => v.toJson()).toList();
    }
    if (this.shippingAddresses != null) {
      data['shipping_addresses'] =
          this.shippingAddresses!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
