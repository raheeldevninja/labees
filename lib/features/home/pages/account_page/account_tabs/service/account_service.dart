import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:labees/core/models/account_data.dart';
import 'package:labees/core/models/news_letter_response.dart';
import 'package:labees/core/models/update_account_response.dart';
import 'package:labees/core/models/update_newsletter_response.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/pages/account_page/model/account_settings_response.dart';
import 'package:labees/features/home/pages/account_page/model/convert_currency_response.dart';
import 'package:labees/features/home/pages/account_page/model/my_points_response.dart';
import 'package:labees/features/home/pages/account_page/model/wallet_response.dart';

/*
*  Date 12 - Now-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: AccountService
*/

class AccountService {
  static Future<UpdateAccountResponse> updateAccount(
      AccountData accountData) async {
    UpdateAccountResponse updateAccountResponse;
    String url = APIs.baseURL + APIs.updateProfile;

    try {
      print('url: $url');
      print('body: ${accountData.toString()}');

      var response = await http.put(Uri.parse(url),
          body: jsonEncode(accountData.toJson()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}'
          });

      print('Response status: ${response.statusCode}');
      print('update account response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        updateAccountResponse = UpdateAccountResponse.fromJson(result);

        updateAccountResponse.success = true;
        //updateAccountResponse.message = 'Success';

        return updateAccountResponse;
      } else if (response.statusCode == 401) {
        return UpdateAccountResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 403) {
        return UpdateAccountResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return UpdateAccountResponse(success: false, message: 'Server Error');
      } else {
        return UpdateAccountResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return UpdateAccountResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return UpdateAccountResponse(success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return UpdateAccountResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<NewsLetterResponse> newsLetter(String email) async {
    NewsLetterResponse newsLetterResponse;
    //String url = APIs.baseURL+APIs.newsletter;
    String url = APIs.baseURL + APIs.updateNewsLetter;

    try {
      print('url: $url');

      var response = await http.post(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('newsletter response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        newsLetterResponse = NewsLetterResponse.fromJson(result);
        return newsLetterResponse;
      } else if (response.statusCode == 401) {
        return NewsLetterResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return NewsLetterResponse(status: false, message: 'Server Error');
      } else {
        return NewsLetterResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return NewsLetterResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return NewsLetterResponse(status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return NewsLetterResponse(status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<UpdateNewsletterResponse> updateNewsletter(int status) async {
    UpdateNewsletterResponse updateNewsletterResponse;
    String url = APIs.baseURL + APIs.updateNewsLetter;

    try {
      print('url: $url');

      var body = {
        'newsletter': status,
      };

      var response =
          await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('update newsletter response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        updateNewsletterResponse = UpdateNewsletterResponse.fromJson(result);
        updateNewsletterResponse.status = true;
        return updateNewsletterResponse;
      } else if (response.statusCode == 401) {
        return UpdateNewsletterResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return UpdateNewsletterResponse(status: false, message: 'Server Error');
      } else {
        return UpdateNewsletterResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return UpdateNewsletterResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return UpdateNewsletterResponse(
          status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return UpdateNewsletterResponse(
          status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<WalletResponse> getWalletList(int limit, int offset) async {
    WalletResponse walletResponse;
    String url =
        '${APIs.baseURL}${APIs.walletList}?limit=$limit&offset=$offset';

    try {
      print('wallet list url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('wallet list response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        walletResponse = WalletResponse.fromJson(result);
        walletResponse.status = true;
        walletResponse.message = 'Success';

        return walletResponse;
      } else if (response.statusCode == 401) {
        return WalletResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return WalletResponse(status: false, message: 'Server Error');
      } else {
        return WalletResponse(status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return WalletResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return WalletResponse(status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return WalletResponse(status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<MyPointsResponse> getMyPoints(int limit, int offset) async {
    MyPointsResponse myPointsResponse;
    String url = '${APIs.baseURL}${APIs.myPoints}?limit=$limit&offset=$offset';

    try {
      print('my points url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      log('my points response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        myPointsResponse = MyPointsResponse.fromJson(result);
        myPointsResponse.status = true;
        myPointsResponse.message = 'Success';

        return myPointsResponse;
      } else if (response.statusCode == 401) {
        return MyPointsResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return MyPointsResponse(status: false, message: 'Server Error');
      } else {
        return MyPointsResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return MyPointsResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return MyPointsResponse(status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return MyPointsResponse(status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<AccountSettingsResponse> getAccountSettings() async {
    AccountSettingsResponse accountSettingsResponse;
    String url = '${APIs.baseURL}${APIs.accountSettings}';

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('account settings response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        accountSettingsResponse = AccountSettingsResponse.fromJson(result);
        accountSettingsResponse.status = true;
        accountSettingsResponse.message = 'Success';

        return accountSettingsResponse;
      } else if (response.statusCode == 401) {
        return AccountSettingsResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return AccountSettingsResponse(status: false, message: 'Server Error');
      } else {
        return AccountSettingsResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return AccountSettingsResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return AccountSettingsResponse(status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return AccountSettingsResponse(
          status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<ConvertToCurrencyResponse> convertToCurrency(int point) async {
    ConvertToCurrencyResponse convertToCurrencyResponse;
    String url = APIs.baseURL + APIs.convertToCurrency;

    try {
      print('url: $url');

      var response = await http.post(Uri.parse(url),
          body: jsonEncode(<String, dynamic>{
            'point': point,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}'
          });

      print('Response status: ${response.statusCode}');
      print('convert to currency response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        convertToCurrencyResponse = ConvertToCurrencyResponse.fromJson(result);
        return convertToCurrencyResponse;
      } else if (response.statusCode == 401) {
        return ConvertToCurrencyResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 422) {
        return ConvertToCurrencyResponse(
            status: false, message: result['message']);
      } else if (response.statusCode == 500) {
        return ConvertToCurrencyResponse(
            status: false, message: 'Server Error');
      } else {
        return ConvertToCurrencyResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return ConvertToCurrencyResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return ConvertToCurrencyResponse(
          status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return ConvertToCurrencyResponse(
          status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
