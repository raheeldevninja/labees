import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/models/add_review_response.dart';
import 'package:labees/core/models/cancel_order_response.dart';
import 'package:labees/core/models/orders_response.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/service/order_service.dart';

class OrderProvider extends ChangeNotifier {
  bool isLoading = false;

  late OrdersResponse ordersResponse;
  late CancelOrderResponse cancelOrderResponse;
  late AddReviewResponse addReviewResponse;

  getOrders(BuildContext context, String orderStatus, int pageSize,
      int currentPage) async {
    //EasyLoading.show(status: 'loading...');
    showLoading();

    ordersResponse =
        await OrderService.getOrders(orderStatus, pageSize, currentPage);

    if (ordersResponse.success!) {
    } else {
      Utils.toast(ordersResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  cancelOrder(BuildContext context, int orderId, String cancelReason) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    cancelOrderResponse = await OrderService.cancelOrder(orderId, cancelReason);

    if (cancelOrderResponse.success!) {
    } else {
      Utils.toast(cancelOrderResponse.message!);
    }

    //EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  addReview(BuildContext context, int productId, String comment, double rating) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    addReviewResponse =
        await OrderService.addReview(productId, comment, rating);

    if (addReviewResponse.status!) {
      Utils.showCustomSnackBar(context, addReviewResponse.message!);
    } else {
      Utils.showCustomSnackBar(context, addReviewResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
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
