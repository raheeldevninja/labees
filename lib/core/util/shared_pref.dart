import 'dart:convert';
import 'package:labees/core/models/cart_product.dart';
import 'package:labees/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
*  Date 8 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: SharedPref helper class
*/

class SharedPref {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userKey = 'user';
  static const String tokenKey = 'token';
  static const String cartProductsKey = 'cart_products';
  static const String showChooseLanguage = 'choose_language_screen_shown';

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, value);
  }

  static Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, json.encode(user.toJson()));
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, token);
  }

  static Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  static Future<void> clearShowChooseLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(showChooseLanguage);
  }

  static Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? userJson = prefs.getString(userKey);

    if (userJson != null && userJson.isNotEmpty) {
      return User.fromJson(json.decode(userJson));
    } else {
      // Return null or some default user instance
      return null;
    }
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey) ?? '';
  }

  //cart product

  // Save the list of CartProducts to shared preferences
  static Future<void> saveCartProducts(List<CartProduct> cartProducts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encoded = jsonEncode(cartProducts);
    prefs.setString(cartProductsKey, encoded);
  }

  // Add a CartProduct to the list and save to shared preferences
  static Future<void> addCartProduct(CartProduct product) async {
    bool isProductExists = false;
    List<CartProduct> cartProducts = await getCartProducts();

    //update product quantity if product id is same
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].id == product.id) {
        //cartProducts[i] = cartProducts[i].copyWith(quantity: cartProducts[i].quantity + product.quantity);
        cartProducts[i] = cartProducts[i].copyWith(quantity: product.quantity);
        isProductExists = true;
      }
    }

    if (!isProductExists) {
      cartProducts.add(product);
    }

    await saveCartProducts(cartProducts);
  }

  static Future<void> clearCartProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartProductsKey);
  }

  // Retrieve the list of CartProducts from shared preferences
  static Future<List<CartProduct>> getCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartProductsString = prefs.getString(cartProductsKey);

    if (cartProductsString != null) {
      Iterable decoded = jsonDecode(cartProductsString);
      return decoded.map((e) => CartProduct.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  // Update a CartProduct in the list and save to shared preferences
  static Future<void> updateCartProduct(CartProduct updatedProduct) async {
    List<CartProduct> cartProducts = await getCartProducts();
    int index =
        cartProducts.indexWhere((element) => element.id == updatedProduct.id);

    if (index != -1) {
      cartProducts[index] = updatedProduct;
      await saveCartProducts(cartProducts);
    }
  }

  // Remove a CartProduct from the list and save to shared preferences
  static Future<void> removeCartProduct(String productId) async {
    List<CartProduct> cartProducts = await getCartProducts();
    cartProducts.removeWhere((element) => element.id == productId);
    await saveCartProducts(cartProducts);
  }

  static Future<void> saveChooseLanguageScreenShown(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(showChooseLanguage, value);
  }

  static Future<bool> isChooseLanguageScreenShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(showChooseLanguage) ?? false;
  }

  static Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
