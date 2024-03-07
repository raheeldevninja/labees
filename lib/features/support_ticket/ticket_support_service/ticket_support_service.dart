import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/support_ticket/model/create_ticket_response.dart';
import 'package:labees/features/support_ticket/model/ticket_support_data.dart';


class TicketSupportService {


  static Future<CreateTicketResponse> createTicketSupport(TicketSupportData ticketSupportData) async {

    CreateTicketResponse createTicketResponse;

    String url = APIs.baseURL+APIs.createTicketSupport;

    try {

      print('create ticket support url: $url');
      print('body: ${ticketSupportData.toJson()}');

      var response = await http.post(
          Uri.parse(url),
          body: jsonEncode(ticketSupportData.toJson()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}',
          }
      );

      print('Response status: ${response.statusCode}');
      print('create ticket support response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        createTicketResponse = CreateTicketResponse.fromJson(result);
        createTicketResponse.status = true;
        createTicketResponse.message = 'Success';
        return createTicketResponse;
      }
      else if (response.statusCode == 401) {

        return CreateTicketResponse(status: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return CreateTicketResponse(status: false, message: 'Server Error');
      }
      else {
        return CreateTicketResponse(status: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return CreateTicketResponse(status: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return CreateTicketResponse(status: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return CreateTicketResponse(status: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }


}