import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/util/apis.dart';
import 'package:http/http.dart' as http;
import 'package:labees/features/settings/model/AllFAQs.dart';
import 'package:labees/features/settings/model/company_settings_response.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:labees/features/settings/model/contact_response.dart';
import 'package:labees/features/settings/model/contact_store_data.dart';
import 'package:labees/features/settings/model/footer_settings_response.dart';
import 'package:labees/features/settings/model/page_details_response.dart';

import '../model/faqs_response.dart';

class SettingsService {
  static Future<ContactResponse> contactUs(
      ContactStoreData contactStoreData) async {
    ContactResponse contactResponse;
    String url = APIs.baseURL + APIs.contactUs;

    try {
      print('url: $url');
      print('body: ${contactStoreData.toString()}');

      var response = await http.post(Uri.parse(url),
          body: jsonEncode(contactStoreData.toJson()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}'
          });

      print('Response status: ${response.statusCode}');
      print('contact us response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        contactResponse = ContactResponse.fromJson(result);

        contactResponse.success = true;

        return contactResponse;
      } else if (response.statusCode == 401) {
        return ContactResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return ContactResponse(success: false, message: 'Server Error');
      } else {
        return ContactResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return ContactResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return ContactResponse(success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return ContactResponse(success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<CompanySettingsResponse> getCompanySettings() async {
    CompanySettingsResponse companySettingsResponse;
    String url = APIs.baseURL + APIs.companySettings;

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print('Response status: ${response.statusCode}');
      print('company settings response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        companySettingsResponse = CompanySettingsResponse.fromJson(result);
        companySettingsResponse.success = true;
        companySettingsResponse.message = 'Success';
        return companySettingsResponse;
      } else if (response.statusCode == 401) {
        return CompanySettingsResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return CompanySettingsResponse(success: false, message: 'Server Error');
      } else {
        return CompanySettingsResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return CompanySettingsResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return CompanySettingsResponse(
          success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return CompanySettingsResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<AllFAQs> getFAQs(String lang) async {
    AllFAQs allFAQs = AllFAQs();
    String url = APIs.baseURL + APIs.faqs;

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'lang': lang == 'en' ? 'en' : 'sa',
      });

      print('Response status: ${response.statusCode}');
      print('faq response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<FAQResponse> faqs =
            (result as List).map((data) => FAQResponse.fromJson(data)).toList();

        allFAQs.faqsResponse = faqs;

        allFAQs.success = true;
        allFAQs.message = 'Success';

        return allFAQs;
      } else if (response.statusCode == 401) {
        return AllFAQs(success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return AllFAQs(success: false, message: 'Server Error');
      } else {
        return AllFAQs(success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return AllFAQs(success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return AllFAQs(success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return AllFAQs(success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<FooterSettingsResponse> getFooterSettings() async {
    FooterSettingsResponse footerSettingsResponse;
    String url = APIs.baseURL + APIs.footerSettings;

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print('Response status: ${response.statusCode}');
      print('footer settings response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        footerSettingsResponse = FooterSettingsResponse.fromJson(result);
        footerSettingsResponse.success = true;
        footerSettingsResponse.message = 'Success';
        return footerSettingsResponse;
      } else if (response.statusCode == 401) {
        return FooterSettingsResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return FooterSettingsResponse(success: false, message: 'Server Error');
      } else {
        return FooterSettingsResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return FooterSettingsResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return FooterSettingsResponse(success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return FooterSettingsResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<PageDetailsResponse> getPageDetails(String slug) async {
    PageDetailsResponse pageDetailsResponse;
    String url = '${APIs.baseURL}${APIs.pageDetails}/$slug';

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print('Response status: ${response.statusCode}');
      print('page details response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        pageDetailsResponse = PageDetailsResponse.fromJson(result);
        pageDetailsResponse.success = true;
        pageDetailsResponse.message = 'Success';
        return pageDetailsResponse;
      } else if (response.statusCode == 401) {
        return PageDetailsResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return PageDetailsResponse(success: false, message: 'Server Error');
      } else {
        return PageDetailsResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return PageDetailsResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return PageDetailsResponse(success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return PageDetailsResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
