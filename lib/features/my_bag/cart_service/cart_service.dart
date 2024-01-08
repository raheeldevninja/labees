import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:labees/core/models/apply_coupon.dart';
import 'package:labees/core/models/checkout_settings.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:labees/core/models/shipping_method.dart';
import 'package:labees/core/util/apis.dart';


class CartService {


  static Future<ShippingMethods> getShippingMethods() async {

    ShippingMethods shippingMethods = ShippingMethods();

    String url = APIs.baseURL+APIs.shippingMethods;

    try {

      print('url: $url');

      var response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }
      );

      print('Response status: ${response.statusCode}');
      print('shipping method response: ${response.body}');

      var result = jsonDecode(response.body);


      if (response.statusCode == 200) {
        //shippingMethod = ShippingMethod.fromJson(result);

        List<ShippingMethod> shippingMethodsList = (result as List)
            .map((data) => ShippingMethod.fromJson(data))
            .toList();

        shippingMethods.data = shippingMethodsList;
        shippingMethods.success = true;
        shippingMethods.message = 'Success';


        return shippingMethods;
      }
      else if (response.statusCode == 401) {

        return ShippingMethods(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return ShippingMethods(success: false, message: 'Server Error');
      }
      else {
        return ShippingMethods(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return ShippingMethods(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return ShippingMethods(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return ShippingMethods(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }


  static Future<CheckoutSettings> getCheckoutSettings() async {

    CheckoutSettings checkoutSettings;
    String url = APIs.baseURL+APIs.checkoutSettings;

    try {

      print('url: $url');

      var response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          }
      );

      print('Response status: ${response.statusCode}');
      print('checkout settings response: ${response.body}');

      var result = jsonDecode(response.body);


      if (response.statusCode == 200) {
        checkoutSettings = CheckoutSettings.fromJson(result);

        checkoutSettings.success = true;
        checkoutSettings.message = 'Success';

        return checkoutSettings;
      }
      else if (response.statusCode == 401) {

        return CheckoutSettings(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return CheckoutSettings(success: false, message: 'Server Error');
      }
      else {
        return CheckoutSettings(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return CheckoutSettings(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return CheckoutSettings(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return CheckoutSettings(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

  static Future<ApplyCoupon> applyCoupon(String code, int subTotal, int shippingCost) async {

    ApplyCoupon applyCoupon;
    String url = '${APIs.baseURL}${APIs.applyCoupon}?code=$code&sub_total=$subTotal&shipping=$shippingCost';

    try {

      print('url: $url');

      var response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}'
          }
      );

      print('Response status: ${response.statusCode}');
      print('apply coupon response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        applyCoupon = ApplyCoupon.fromJson(result);

        applyCoupon.success = true;
        applyCoupon.message = 'Success';


        return applyCoupon;
      }
      else if (response.statusCode == 401) {

        return ApplyCoupon(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return ApplyCoupon(success: false, message: 'Server Error');
      }
      else if (response.statusCode == 202) {
        return ApplyCoupon(success: false, message: 'Invalid coupon');
      }
      else {
        return ApplyCoupon(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return ApplyCoupon(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return ApplyCoupon(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return ApplyCoupon(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

}