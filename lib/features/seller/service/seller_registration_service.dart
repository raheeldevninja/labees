import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/seller/model/seller_products_response.dart';
import 'package:labees/features/seller/model/seller_profile_response.dart';
import 'package:labees/features/seller/model/seller_registration_data.dart';
import 'package:labees/features/seller/model/seller_registration_response.dart';

class SellerRegistrationService {
  static Future<SellerRegistrationResponse> sellerRegister(
      SellerRegistrationData sellerRegistrationData) async {
    SellerRegistrationResponse sellerRegistrationResponse;
    String url = APIs.baseURL + APIs.sellerRegister;

    try {
      print('seller registration url: $url');
      print('body: ${sellerRegistrationData.toString()}');

      /*
      var response = await http.post(
          Uri.parse(url),
          body: jsonEncode(sellerRegistrationData.toMap()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}'
          }
      );

      print('Response status: ${response.statusCode}');
      print('registration response: ${response.body}');

      var result = jsonDecode(response.body);
      */

      var headers = {'lang': 'en', 'Authorization': 'Bearer ${APIs.token}'};

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({
        'f_name': sellerRegistrationData.fName,
        'l_name': sellerRegistrationData.lName,
        'email': sellerRegistrationData.email,
        'phone': sellerRegistrationData.phone,
        'password': sellerRegistrationData.password,
        'shop_name': sellerRegistrationData.shopName,
        'shop_address': sellerRegistrationData.shopAddress,
        'commercial_document':
            sellerRegistrationData.commercialDocument.toString(),
        'cr_id_no': sellerRegistrationData.crIDNo,
      });

      request.files.add(await http.MultipartFile.fromPath(
          'cr_freelance_document', sellerRegistrationData.crFreelanceDocPath));
      request.files.add(await http.MultipartFile.fromPath(
          'image', sellerRegistrationData.imagePath));
      request.files.add(await http.MultipartFile.fromPath(
          'logo', sellerRegistrationData.logoPath));
      request.files.add(await http.MultipartFile.fromPath(
          'banner', sellerRegistrationData.bannerPath));
      request.files.add(await http.MultipartFile.fromPath(
          'additional_legal_document',
          sellerRegistrationData.additionalLegalDocPath));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var res = await response.stream.bytesToString();
      var result = jsonDecode(res);

      var body = {
        'f_name': sellerRegistrationData.fName,
        'l_name': sellerRegistrationData.lName,
        'email': sellerRegistrationData.email,
        'phone': sellerRegistrationData.phone,
        'password': sellerRegistrationData.password,
        'shop_name': sellerRegistrationData.shopName,
        'shop_address': sellerRegistrationData.shopAddress,
        'commercial_document':
            sellerRegistrationData.commercialDocument.toString(),
        'cr_id_no': sellerRegistrationData.crIDNo,
      };

      print('url: $url');
      print('body: ${body.toString()}');
      print('status code: ${response.statusCode}');
      print('seller registration response: $res');

      if (response.statusCode == 200) {
        sellerRegistrationResponse =
            SellerRegistrationResponse.fromJson(result);
        sellerRegistrationResponse.success = true;
        return sellerRegistrationResponse;
      } else if (response.statusCode == 401) {
        return SellerRegistrationResponse(
            success: false, message: 'Unauthorized');
      } else if (response.statusCode == 403) {
        return SellerRegistrationResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return SellerRegistrationResponse(
            success: false, message: 'Server Error');
      } else {
        return SellerRegistrationResponse(
            success: false, message: 'Something went wrong !');
      }

      /*if (response.statusCode == 200) {
        sellerRegistrationResponse = SellerRegistrationResponse.fromJson(result);
        sellerRegistrationResponse.success = true;
        sellerRegistrationResponse.message = 'Success';
        return sellerRegistrationResponse;
      }
      else if (response.statusCode == 401) {

        return SellerRegistrationResponse(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 403) {

        return SellerRegistrationResponse(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return SellerRegistrationResponse(success: false, message: 'Server Error');
      }
      else {
        return SellerRegistrationResponse(success: false, message: 'Something went wrong !');
      }*/
    } on SocketException {
      return SellerRegistrationResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return SellerRegistrationResponse(
          success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return SellerRegistrationResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }


  static Future<SellerProfileResponse> getSellerProfile(int sellerId) async {

    SellerProfileResponse sellerProfileResponse = SellerProfileResponse();
    String url = '${APIs.baseURL}${APIs.sellerProfile}?seller_id=$sellerId';

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('seller profile response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {

        sellerProfileResponse = SellerProfileResponse.fromJson(result);

        sellerProfileResponse.success = true;
        sellerProfileResponse.message = 'Success';

        return sellerProfileResponse;
      } else if (response.statusCode == 401) {
        return SellerProfileResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return SellerProfileResponse(success: false, message: 'Server Error');
      } else {
        return SellerProfileResponse(success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return SellerProfileResponse(success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (_) {
      return SellerProfileResponse(success: false, message: 'Request timeout');
    } on FormatException catch (_) {
      return SellerProfileResponse(success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }


  static Future<SellerProductsResponse> getSellerProducts(int sellerId, int limit, int offset, String search) async {

    SellerProductsResponse sellerProductsResponse = SellerProductsResponse();
    String url = '${APIs.baseURL}${APIs.sellerProfile}/$sellerId/all-products?limit=$limit&offset=$offset&search=$search';

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('seller products response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {

        sellerProductsResponse = SellerProductsResponse.fromJson(result);

        sellerProductsResponse.success = true;
        sellerProductsResponse.message = 'Success';

        return sellerProductsResponse;
      } else if (response.statusCode == 401) {
        return SellerProductsResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return SellerProductsResponse(success: false, message: 'Server Error');
      } else {
        return SellerProductsResponse(success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return SellerProductsResponse(success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (_) {
      return SellerProductsResponse(success: false, message: 'Request timeout');
    } on FormatException catch (_) {
      return SellerProductsResponse(success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }


}
