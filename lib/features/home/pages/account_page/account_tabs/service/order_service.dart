import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:labees/core/models/add_review_response.dart';
import 'package:labees/core/models/cancel_order_response.dart';
import 'package:labees/core/models/orders_response.dart';
import 'package:labees/core/util/apis.dart';


class OrderService {

  static Future<OrdersResponse> getOrders(String orderStatus, int pageSize, int currentPage) async {

    OrdersResponse ordersResponse;
    String url = '${APIs.baseURL}${APIs.getOrders}?order_status=$orderStatus&pageSize=$pageSize&currentPage=$currentPage';

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
      print('get orders response: ${response.body}');

      var result = jsonDecode(response.body);


      if (response.statusCode == 200) {
        ordersResponse = OrdersResponse.fromJson(result);

        ordersResponse.success = true;
        ordersResponse.message = 'Orders fetched successfully';

        return ordersResponse;
      }
      else if (response.statusCode == 401) {

        return OrdersResponse(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return OrdersResponse(success: false, message: 'Server Error');
      }
      else {
        return OrdersResponse(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return OrdersResponse(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return OrdersResponse(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return OrdersResponse(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }


  static Future<CancelOrderResponse> cancelOrder(int orderId, String cancelReason) async {

    CancelOrderResponse cancelOrderResponse;
    String url = '${APIs.baseURL}${APIs.cancelOrders}?order_id=$orderId&cancel_reason=$cancelReason';

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
      print('cancel order response: ${response.body}');

      var result = jsonDecode(response.body);


      if (response.statusCode == 200) {
        cancelOrderResponse = CancelOrderResponse();

        cancelOrderResponse.success = true;
        //cancelOrderResponse.message = 'Order canceled successfully';
        cancelOrderResponse.message = result;

        return cancelOrderResponse;
      }
      else if (response.statusCode == 401) {

        return CancelOrderResponse(success: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return CancelOrderResponse(success: false, message: 'Server Error');
      }
      else {
        return CancelOrderResponse(success: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return CancelOrderResponse(success: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return CancelOrderResponse(success: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return CancelOrderResponse(success: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }



  static Future<AddReviewResponse> addReview(int productId, String comment, double rating) async {

    AddReviewResponse addReviewResponse;
    String url = APIs.baseURL+APIs.addReview;

    try {

      print('url: $url');

      var body = {
        'product_id': productId,
        'comment': comment,
        'rating': rating
      };

      var response = await http.post(
          Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${APIs.token}'
          }
      );

      print('Response status: ${response.statusCode}');
      print('add rewview response: ${response.body}');

      var result = jsonDecode(response.body);


      if (response.statusCode == 200) {
        addReviewResponse = AddReviewResponse.fromJson(result);

        addReviewResponse.status = true;

        return addReviewResponse;
      }
      else if (response.statusCode == 401) {

        return AddReviewResponse(status: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 403) {

        return AddReviewResponse(status: false, message: result['errors'][0]['message']);
      }
      else if (response.statusCode == 500) {
        return AddReviewResponse(status: false, message: 'Server Error');
      }
      else {
        return AddReviewResponse(status: false, message: 'Something went wrong !');
      }
    }
    on SocketException {
      return AddReviewResponse(status: false, message: 'Not connect to internet !');
    }
    on TimeoutException catch (e) {
      return AddReviewResponse(status: false, message: 'Request timeout');
    }
    on FormatException catch (e) {
      return AddReviewResponse(status: false, message: 'Bad response format');
    }
    finally {
      EasyLoading.dismiss();
    }
  }


}