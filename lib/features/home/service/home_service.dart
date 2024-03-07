import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/models/all_wishlist_products.dart';
import 'package:labees/core/models/filter_data.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/attribute_detail.dart';
import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/models/dashboard_data.dart';
import 'package:labees/features/home/models/get_wishlist.dart';
import 'package:labees/features/home/models/main_categories.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:labees/features/home/models/product_model.dart';
import 'package:labees/features/home/models/tag.dart';
import 'package:labees/features/products/model/add_wish_list_response.dart';
import 'package:labees/features/products/model/product_details.dart';
import 'package:labees/features/products/model/wish_list_remove_response.dart';


class HomeService {

  static Future<MainCategories> getMainCategories(String lang) async {

    MainCategories mainCategories;
    String url = APIs.baseURL+APIs.mainCategories;

    try {

      print('url: $url');

      var response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
            'lang': lang == 'en' ? 'en' : 'sa',
          }
      );

      print('Response status: ${response.statusCode}');
      log('main categories response: ${response.body}');

      var result = jsonDecode(response.body);


      if (response.statusCode == 200) {
        mainCategories = MainCategories.fromJson(result);
        mainCategories.success = true;
        mainCategories.message = 'Success';
        return mainCategories;
      }
      else if (response.statusCode == 401) {

        return MainCategories(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return MainCategories(success: false, message: 'Server Error');
      }
      else {
        return MainCategories(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return MainCategories(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return MainCategories(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return MainCategories(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

  static Future<DashboardData> getDashboardData(String lang, int categoryId, String allowedData) async {

    DashboardData dashboardData;
    String url = '${APIs.baseURL}${APIs.dashboardData}?category_id=$categoryId&allowed_data=$allowedData';

    try {

      print('url: $url');

      var response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
            'lang': lang == 'en' ? 'en' : 'sa',
          },
      );

      print('dashboard data status: ${response.statusCode}');
      log('dashboard data response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        dashboardData = DashboardData.fromJson(result);
        dashboardData.success = true;
        dashboardData.message = 'Success';
        return dashboardData;
      }
      else if (response.statusCode == 401) {

        return DashboardData(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return DashboardData(success: false, message: 'Server Error');
      }
      else {
        return DashboardData(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return DashboardData(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return DashboardData(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return DashboardData(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

  static Future<ProductModel> getProducts(String lang, int id, int limit,
      int offset, String sort,
      {String? minAmount, String? maxAmount, List<SubCategories>? subCategories, List<Brand> ? brands,
        List<AttributeValues>? sizeAttributes,
        List<AttributeValues>? colorAttributes,
        List<AttributeValues>? ukSizeAttributes,
        List<Tag>? tags,
      }) async {
      //{FilterData? filterData}) async {

    ProductModel productModel;
    String? url;

    url = '${APIs.baseURL}${APIs.productListing}$id?limit=$limit&offset=$offset&sort=$sort';



    if(minAmount != null) {
      url += '&filters[min_amount_filter]=$minAmount&filters[max_amount_filter]=$maxAmount';
    }

    if(subCategories != null) {

      String subCategoriesString = '';

      for(int i = 0; i < subCategories.length; i++) {


        if(subCategories[i].isSelected) {
          subCategoriesString += '&filters[sub_categories_filter]';
          subCategoriesString += '[$i]=${subCategories[i].id}';
        }

      }

      url += subCategoriesString;
    }

    if(sizeAttributes != null) {

      String sizeString = '';

      for(int i = 0; i < sizeAttributes.length; i++) {

        if(sizeAttributes[i].isSelected) {
          sizeString += '&filters[attribute_values_filter]';
          sizeString += '[$i]=${sizeAttributes[i].id}';
        }

      }

      url += sizeString;
    }

    if(brands != null) {

      String brandsString = '';

      for(int i = 0; i < brands.length; i++) {


        if(brands[i].isSelected) {
          brandsString += '&filters[brands_filter]';
          brandsString += '[$i]=${brands[i].id}';
        }

      }

      url += brandsString;
    }

    if(colorAttributes != null) {

      String colorString = '';

      for(int i = 0; i < colorAttributes.length; i++) {

        if(colorAttributes[i].isSelected) {
          colorString += '&filters[attribute_values_filter]';
          colorString += '[$i]=${colorAttributes[i].id}';
        }

      }

      url += colorString;
    }


    //tags
    if(tags != null) {

      String tagsString = '';

      for(int i = 0; i < tags.length; i++) {

        if(tags[i].isSelected) {
          tagsString += '&filters[tags_filter]';
          tagsString += '[$i]=${tags[i].id}';
        }

      }

      url += tagsString;
    }


    if(ukSizeAttributes != null) {

      String ukSizeString = '';

      for(int i = 0; i < ukSizeAttributes.length; i++) {

        if(ukSizeAttributes[i].isSelected) {
          ukSizeString += '&filters[attribute_values_filter]';
          ukSizeString += '[$i]=${ukSizeAttributes[i].id}';
        }

      }

      url += ukSizeString;
    }


    try {

      //String body = jsonEncode(filterData?.toJson());


      print('url: $url');
      //print('url: ${Uri.https('https://labees.boedelipos.ch/api/v1', '/${APIs.productListing}', filterData?.toJson())}');

      var response = await http.get(
        //filterData != null ? Uri.parse(url).replace(queryParameters: filterData.toJson()) :
        Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
            'lang': lang == 'en' ? 'en' : 'sa',
          },
      );

      print('product listing status: ${response.statusCode}');
      log('product listing response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        productModel = ProductModel.fromJson(result);
        productModel.success = true;
        productModel.message = 'Success';
        return productModel;
      }
      else if (response.statusCode == 401) {

        return ProductModel(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return ProductModel(success: false, message: 'Server Error');
      }
      else {
        return ProductModel(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return ProductModel(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return ProductModel(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return ProductModel(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

  static Future<ProductDetails> getProductDetails(String lang, String slug) async {

    ProductDetails productDetails;
    String url = '${APIs.baseURL}${APIs.productDetails}$slug';
    //String url = '${APIs.baseURL}${APIs.productDetails}tommy-shirt-red-RwfQQB';

    try {

      print('url: $url');

      var response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
            'lang': lang == 'en' ? 'en' : 'sa',
          }
      );

      print('product details status: ${response.statusCode}');
      //print('product details response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        productDetails = ProductDetails.fromJson(result);
        productDetails.success = true;
        productDetails.message = 'Success';
        return productDetails;
      }
      else if (response.statusCode == 401) {

        return ProductDetails(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return ProductDetails(success: false, message: 'Server Error');
      }
      else {
        return ProductDetails(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return ProductDetails(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return ProductDetails(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return ProductDetails(success: false, message: 'Bad response format');
    }
    catch(e) {
      print('error message: ${e.toString()}');
      return ProductDetails(success: false, message: 'Something went wrong !');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

  static Future<AddWishListResponse> addToWishlist(String lang, int productId) async {

    AddWishListResponse addWishListResponse;
    String url = APIs.baseURL+APIs.addToWishlist;

    try {

      print('add wishlist url: $url');

      var response = await http.post(
          Uri.parse(url),
          body: jsonEncode({
            'product_id': productId,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
            'lang': lang == 'en' ? 'en' : 'sa',
          }
      );

      print('Response status: ${response.statusCode}');
      print('add to wishlist response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        addWishListResponse = AddWishListResponse.fromJson(result);
        addWishListResponse.success = true;
        return addWishListResponse;
      }
      else if (response.statusCode == 401) {

        return AddWishListResponse(success: false, message: result['message']);
      }
      else if (response.statusCode == 409) {

        return AddWishListResponse(success: false, message: result['message']);
      }
      else if (response.statusCode == 500) {
        return AddWishListResponse(success: false, message: 'Server Error');
      }
      else {
        return AddWishListResponse(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return AddWishListResponse(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return AddWishListResponse(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return AddWishListResponse(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

  static Future<WishListRemoveResponse> removeFromWishlist(int productId) async {

    WishListRemoveResponse wishListRemoveResponse;
    String url = '${APIs.baseURL}${APIs.removeFromWishlist}?product_id=$productId';

    try {

      print('remove from wishlist url: $url');

      var response = await http.delete(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
          }
      );

      print('Response status: ${response.statusCode}');
      log('remove from wishlist response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        wishListRemoveResponse = WishListRemoveResponse.fromJson(result);
        wishListRemoveResponse.success = true;
        return wishListRemoveResponse;
      }
      else if (response.statusCode == 401) {

        return WishListRemoveResponse(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 409) {

        return WishListRemoveResponse(success: false, message: result['message']);
      }
      else if (response.statusCode == 500) {
        return WishListRemoveResponse(success: false, message: 'Server Error');
      }
      else {
        return WishListRemoveResponse(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return WishListRemoveResponse(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return WishListRemoveResponse(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return WishListRemoveResponse(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

  static Future<AllWishlistProducts> getWishlist(String lang) async {

    AllWishlistProducts allWishlistProducts = AllWishlistProducts();

    String url = APIs.baseURL+APIs.getWishlist;

    try {

      print('url: $url');

      var response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
            'lang': lang == 'en' ? 'en' : 'sa',
          }
      );

      print('Response status: ${response.statusCode}');
      print('get wishlist response: ${response.body}');

      var result = jsonDecode(response.body)['wishlist'];


      if (response.statusCode == 200) {

        List<GetWishlist> wishlistLists = (result as List)
            .map((data) => GetWishlist.fromJson(data))
            .toList();

        allWishlistProducts.wishlistProducts = wishlistLists;

        allWishlistProducts.success = true;
        allWishlistProducts.message = 'Success';

        return allWishlistProducts;
      }
      else if (response.statusCode == 401) {

        return AllWishlistProducts(success: false, message: jsonDecode(response.body)['message']);
      }
      else if (response.statusCode == 500) {
        return AllWishlistProducts(success: false, message: 'Server Error');
      }
      else {
        return AllWishlistProducts(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return AllWishlistProducts(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return AllWishlistProducts(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return AllWishlistProducts(success: false, message: 'Bad response format');
    }
    catch(e) {
      print('wishlist error message: ${e.toString()}');
      return AllWishlistProducts(success: false, message: 'Something went wrong !');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

}