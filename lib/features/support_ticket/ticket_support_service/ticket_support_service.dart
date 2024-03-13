import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/support_ticket/model/create_ticket_response.dart';
import 'package:labees/features/support_ticket/model/delete_ticket_support_response.dart';
import 'package:labees/features/support_ticket/model/ticket_support_data.dart';
import 'package:labees/features/support_ticket/model/ticket_support_details_response.dart';
import 'package:labees/features/support_ticket/model/ticket_support_list_response.dart';

class TicketSupportService {
  static Future<CreateTicketResponse> createTicketSupport(
      TicketSupportData ticketSupportData) async {
    CreateTicketResponse createTicketResponse;

    String url = APIs.baseURL + APIs.createTicketSupport;

    try {
      print('create ticket support url: $url');
      print('body: ${ticketSupportData.toJson()}');

      var response = await http.post(Uri.parse(url),
          body: jsonEncode(ticketSupportData.toJson()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
          });

      print('Response status: ${response.statusCode}');
      print('create ticket support response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        createTicketResponse = CreateTicketResponse.fromJson(result);
        createTicketResponse.status = true;
        createTicketResponse.message = 'Success';
        return createTicketResponse;
      } else if (response.statusCode == 401) {
        return CreateTicketResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return CreateTicketResponse(status: false, message: 'Server Error');
      } else {
        return CreateTicketResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return CreateTicketResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return CreateTicketResponse(status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return CreateTicketResponse(
          status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<TicketSupportResponse> getTicketSupportList() async {
    TicketSupportResponse ticketSupportResponse = TicketSupportResponse();
    String url = '${APIs.baseURL}${APIs.ticketSupportList}';

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('ticket support list response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<TicketSupportListResponse> ticketSupportList = (result as List)
            .map((data) => TicketSupportListResponse.fromJson(data))
            .toList();

        ticketSupportResponse.data = ticketSupportList;

        ticketSupportResponse.success = true;
        ticketSupportResponse.message = 'Success';

        return ticketSupportResponse;
      } else if (response.statusCode == 401) {
        return TicketSupportResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return TicketSupportResponse(success: false, message: 'Server Error');
      } else {
        return TicketSupportResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return TicketSupportResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (_) {
      return TicketSupportResponse(success: false, message: 'Request timeout');
    } on FormatException catch (_) {
      return TicketSupportResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<DeleteTicketSupportResponse> deleteTicketSupport(int id) async {
    DeleteTicketSupportResponse deleteTicketSupportResponse;

    String url = '${APIs.baseURL}${APIs.ticketSupportDelete}?id=$id';

    try {
      print('url: $url');
      print('body: ');

      var response = await http.delete(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('delete address response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        deleteTicketSupportResponse = DeleteTicketSupportResponse.fromJson(result);
        deleteTicketSupportResponse.success = true;

        return deleteTicketSupportResponse;
      } else if (response.statusCode == 401) {
        return DeleteTicketSupportResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 400) {
        return DeleteTicketSupportResponse(
            success: false, message: result['message']);
      } else if (response.statusCode == 500) {
        return DeleteTicketSupportResponse(success: false, message: 'Server Error');
      } else {
        return DeleteTicketSupportResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return DeleteTicketSupportResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (_) {
      return DeleteTicketSupportResponse(success: false, message: 'Request timeout');
    } on FormatException catch (_) {
      return DeleteTicketSupportResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }


  static Future<TicketSupportDetailsResponse> getTicketSupportDetails(int id) async {

    TicketSupportDetailsResponse ticketSupportDetailsResponse;

    String url = '${APIs.baseURL}${APIs.ticketSupportDetails}/$id';

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      print('ticket support details response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {

        ticketSupportDetailsResponse = TicketSupportDetailsResponse.fromJson(result);

        ticketSupportDetailsResponse.success = true;
        ticketSupportDetailsResponse.message = 'Success';

        return ticketSupportDetailsResponse;
      } else if (response.statusCode == 401) {
        return TicketSupportDetailsResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return TicketSupportDetailsResponse(success: false, message: 'Server Error');
      } else {
        return TicketSupportDetailsResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return TicketSupportDetailsResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (_) {
      return TicketSupportDetailsResponse(success: false, message: 'Request timeout');
    } on FormatException catch (_) {
      return TicketSupportDetailsResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }


}
