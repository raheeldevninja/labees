import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:labees/core/models/add_address_response.dart';
import 'package:labees/core/models/address_data.dart';
import 'package:labees/core/models/all_addresses.dart';
import 'package:labees/core/models/cities_data.dart';
import 'package:labees/core/models/countries_data.dart';
import 'package:labees/core/models/delete_address_response.dart';
import 'package:labees/core/models/place_order_model.dart';
import 'package:labees/core/models/place_order_response.dart';
import 'package:labees/core/models/update_address_response.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/address_data.dart';

class CheckoutService {

  static Future<Countries> getCountries() async {

    Countries countries = Countries();
    String url = APIs.baseURL+APIs.countriesList;

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
      print('countries response: ${response.body}');

      var result = jsonDecode(response.body);


      if (response.statusCode == 200) {

        List<CountriesData> countriesList = (result as List)
            .map((data) => CountriesData.fromJson(data))
            .toList();

        countries.data = countriesList;

        countries.success = true;
        countries.message = 'Success';

        return countries;
      }
      else if (response.statusCode == 401) {

        return Countries(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return Countries(success: false, message: 'Server Error');
      }
      else {
        return Countries(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return Countries(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return Countries(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return Countries(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

  static Future<Cities> getCities(int countryId) async {

    Cities cities = Cities();
    String url = '${APIs.baseURL}${APIs.citiesList}$countryId';

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
      print('cities response: ${response.body}');

      var result = jsonDecode(response.body);


      if (response.statusCode == 200) {

        List<CitiesData> citiesList = (result as List)
            .map((data) => CitiesData.fromJson(data))
            .toList();

        cities.data = citiesList;

        cities.success = true;
        cities.message = 'Success';

        return cities;
      }
      else if (response.statusCode == 401) {

        return Cities(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return Cities(success: false, message: 'Server Error');
      }
      else {
        return Cities(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return Cities(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return Cities(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return Cities(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }



  static Future<AddAddressResponse> addAddress(AddressModel addressModel) async {

    AddAddressResponse addAddressResponse;
    String url = APIs.baseURL+APIs.addAddress;

    try {

      print('billing address url: $url');
      print('body: ${addressModel.toString()}');

      var response = await http.post(
          Uri.parse(url),
          body: jsonEncode(addressModel.toJson()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
          }
      );

      print('Response status: ${response.statusCode}');
      print('add billing address response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        addAddressResponse = AddAddressResponse.fromJson(result);
        addAddressResponse.success = true;
        addAddressResponse.message = 'Success';
        return addAddressResponse;
      }
      else if (response.statusCode == 401) {

        return AddAddressResponse(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return AddAddressResponse(success: false, message: 'Server Error');
      }
      else {
        return AddAddressResponse(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return AddAddressResponse(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return AddAddressResponse(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return AddAddressResponse(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }


  static Future<UpdateAddressResponse> updateAddress(AddressModel addressModel) async {

    UpdateAddressResponse updateAddressResponse;




    //String url = '${APIs.baseURL}${APIs.updateAddress}${addressModel.queryString()}';
    String url = '${APIs.baseURL}${APIs.updateAddress}';

    try {

      print('update address url: $url');
      print('body: ${addressModel.toString()}');

      var response = await http.put(
          Uri.parse(url),
          body: jsonEncode(addressModel.toJson()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
          }
      );

      print('Response status: ${response.statusCode}');
      print('update address response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        updateAddressResponse = UpdateAddressResponse.fromJson(result);
        updateAddressResponse.success = true;
        updateAddressResponse.message = 'Success';
        return updateAddressResponse;
      }
      else if (response.statusCode == 401) {

        return UpdateAddressResponse(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return UpdateAddressResponse(success: false, message: 'Server Error');
      }
      else {
        return UpdateAddressResponse(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return UpdateAddressResponse(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return UpdateAddressResponse(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return UpdateAddressResponse(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }


  static Future<AllAddresses> getAllAddresses() async {

    AllAddresses allAddresses = AllAddresses();
    String url = '${APIs.baseURL}${APIs.allAddresses}';

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
      print('all addresses response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {

        List<AddressData> addressesList = (result as List)
            .map((data) => AddressData.fromJson(data))
            .toList();

        allAddresses.addresses = addressesList;

        allAddresses.success = true;
        allAddresses.message = 'Success';

        return allAddresses;
      }
      else if (response.statusCode == 401) {

        return AllAddresses(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return AllAddresses(success: false, message: 'Server Error');
      }
      else {
        return AllAddresses(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return AllAddresses(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return AllAddresses(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return AllAddresses(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }


  static Future<PlaceOrderResponse> placeOrder(PlaceOrderModel placeOrderModel) async {

    PlaceOrderResponse placeOrderResponse;
    String url = '${APIs.baseURL}${APIs.placeOrder}';

    try {

      print('url: $url');
      print('body: ${jsonEncode(placeOrderModel.toJson())}');

      var response = await http.post(
          body: jsonEncode(placeOrderModel.toJson()),
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}'
          }
      );

      print('Response status: ${response.statusCode}');
      print('place order response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {

        placeOrderResponse = PlaceOrderResponse.fromJson(result);

        placeOrderResponse.status = 1;

        return placeOrderResponse;
      }
      else if (response.statusCode == 401) {

        return PlaceOrderResponse(status: 0, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 400) {

        return PlaceOrderResponse(status: result['status'], message: result['message']);
      }
      else if (response.statusCode == 500) {
        return PlaceOrderResponse(status: 0, message: 'Server Error');
      }
      else {
        return PlaceOrderResponse(status: 0, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return PlaceOrderResponse(status: 0, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return PlaceOrderResponse(status: 0, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return PlaceOrderResponse(status: 0, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }


  static Future<DeleteAddressResponse> deleteAddress(int id) async {

    DeleteAddressResponse deleteAddressResponse;
    String url = '${APIs.baseURL}${APIs.deleteAddress}?address_id=$id';

    try {

      print('url: $url');
      print('body: ');

      var response = await http.delete(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}'
          }
      );

      print('Response status: ${response.statusCode}');
      print('delete address response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {

        deleteAddressResponse = DeleteAddressResponse.fromJson(result);
        deleteAddressResponse.success = true;

        return deleteAddressResponse;
      }
      else if (response.statusCode == 401) {

        return DeleteAddressResponse(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 400) {

        return DeleteAddressResponse(success: false, message: result['message']);
      }
      else if (response.statusCode == 500) {
        return DeleteAddressResponse(success: false, message: 'Server Error');
      }
      else {
        return DeleteAddressResponse(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return DeleteAddressResponse(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return DeleteAddressResponse(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return DeleteAddressResponse(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

}