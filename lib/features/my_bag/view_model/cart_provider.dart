import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/models/apply_coupon.dart';
import 'package:labees/core/models/cart_product.dart';
import 'package:labees/core/models/checkout_settings.dart';
import 'package:labees/core/models/shipping_method.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/my_bag/cart_service/cart_service.dart';

class CartProvider extends ChangeNotifier {

  bool isLoading = false;

  late ShippingMethods shippingMethods;
  late CheckoutSettings checkoutSettings;
  ApplyCoupon? applyCouponResponse;

  List<CartProduct> cartProducts = [];

  List<ShippingMethod> shippingMethodsList = [];

  ShippingMethod? selectedShippingMethod;

  double subTotal = 0.0;
  double vat = 0.0;
  double couponDiscount = 0.0;

  Future<void> getCartProducts() async {
    cartProducts = await SharedPref.getCartProducts();

    notifyListeners();
  }

  Future<void> removeCartProduct(CartProduct product) async {
    cartProducts.remove(product);
    await SharedPref.saveCartProducts(cartProducts);
    notifyListeners();
  }

  Future<void> incrementQuantity(int index) async {

    //cart products
    int quantity = cartProducts[index].quantity;

    cartProducts[index] = cartProducts[index].copyWith(quantity: ++quantity, totalPrice: cartProducts[index].unitPrice * quantity);

    print('updated product quantity: ${cartProducts[index].quantity}');

    notifyListeners();

    await SharedPref.saveCartProducts(cartProducts);
  }


  Future<void> decrementQuantity(int index) async {

    int quantity = cartProducts[index].quantity;

    if (quantity == 1) {
      return;
    }

    cartProducts[index] = cartProducts[index].copyWith(quantity: --quantity, totalPrice: cartProducts[index].unitPrice * quantity);

    print('updated product quantity: ${cartProducts[index].quantity}');

    notifyListeners();

    await SharedPref.saveCartProducts(cartProducts);

  }

  //cart product to cart and in save in shared pref
  Future<void> addProductToCart(CartProduct product) async {
    cartProducts.add(product);
    await SharedPref.saveCartProducts(cartProducts);
    notifyListeners();
  }


  Future<void> getShippingMethods() async {

    //EasyLoading.show(status: 'loading...');
    showLoading();

    shippingMethods = await CartService.getShippingMethods();

    if (shippingMethods.success) {
      shippingMethodsList = shippingMethods.data!;
    }
    else {
      Utils.toast(shippingMethods.message!);
    }


    //EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  List<ShippingMethod> get getShippingMethodsList => shippingMethodsList;


  setSelectShippingMethod(ShippingMethod shippingMethod) {
    selectedShippingMethod = shippingMethod;
    notifyListeners();
  }

  ShippingMethod? getSelectedShippingMethod() {

    if(selectedShippingMethod == null) {
      return null;
    }

    return selectedShippingMethod!;
  }


  Future<void> getCheckoutSettings() async {

    showLoading();

    checkoutSettings = await CartService.getCheckoutSettings();

    if (checkoutSettings.success!) {

    }
    else {
      Utils.toast(checkoutSettings.message!);
    }

    hideLoading();
    notifyListeners();
  }

  double calculateSubTotal() {

    subTotal = 0.0;
    for (var element in cartProducts) {
      subTotal += element.unitPrice * element.quantity;
    }
    return subTotal;
  }

  Future<void> applyCoupon(String code, int subTotal, int shippingCost) async {

    EasyLoading.show(status: 'loading...');
    showLoading();

    applyCouponResponse = await CartService.applyCoupon(code, subTotal, shippingCost);

    if (applyCouponResponse!.success!) {
      setCouponDiscount();
    }
    else {
      couponDiscount = 0.0;
      Utils.toast(applyCouponResponse!.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  calculateCouponDiscount() {

    if(applyCouponResponse == null || applyCouponResponse!.data == null) {
      return;
    }

    if(applyCouponResponse!.data!.coupon!.discountType == 'percentage') {
      couponDiscount = (applyCouponResponse!.data!.coupon!.discount! / 100) * subTotal;
    }
    else {
      couponDiscount = applyCouponResponse!.data!.coupon!.discount!.toDouble();
    }

    notifyListeners();
  }

  setCouponDiscount() {

    if(applyCouponResponse == null || applyCouponResponse!.data == null) {
      return;
    }

    couponDiscount = applyCouponResponse!.data!.couponDiscount!.toDouble();
    notifyListeners();

  }


  showLoading() {
    isLoading = true;
    notifyListeners();
  }

  hideLoading() {
    isLoading = false;
    notifyListeners();
  }

}