import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/support_ticket/model/close_ticket_support_response.dart';
import 'package:labees/features/support_ticket/model/create_ticket_response.dart';
import 'package:labees/features/support_ticket/model/delete_ticket_support_response.dart';
import 'package:labees/features/support_ticket/model/send_messgae_response.dart';
import 'package:labees/features/support_ticket/model/ticket_support_data.dart';
import 'package:labees/features/support_ticket/model/ticket_support_details_response.dart';
import 'package:labees/features/support_ticket/model/ticket_support_list_response.dart';
import 'package:labees/features/support_ticket/ticket_support_service/ticket_support_service.dart';

class TicketSupportProvider extends ChangeNotifier {
  bool isLoading = false;

  bool get getIsLoading => isLoading;

  CreateTicketResponse? createTicketResponse;
  TicketSupportResponse? ticketSupportResponse;
  List<TicketSupportListResponse>? ticketSupportLists = [];

  DeleteTicketSupportResponse? deleteTicketSupportResponse;
  TicketSupportDetailsResponse? ticketSupportDetailsResponse;
  CloseTicketSupportResponse? closeTicketSupportResponse;
  SendMessageResponse? sendMessageResponse;

  createTicketSupport(
      BuildContext context, TicketSupportData ticketSupportData) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    createTicketResponse =
        await TicketSupportService.createTicketSupport(ticketSupportData);

    if (createTicketResponse!.status!) {
      Utils.showCustomSnackBar(context, createTicketResponse!.message!, ContentType.success);
      Navigator.pop(context);
    } else {
      Utils.showCustomSnackBar(context, createTicketResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> getTicketSupportList(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    ticketSupportResponse = await TicketSupportService.getTicketSupportList();

    if(!context.mounted) {
      return;
    }

    if (ticketSupportResponse!.success!) {
      ticketSupportLists = ticketSupportResponse!.data!;
    } else {
      Utils.showCustomSnackBar(context, ticketSupportResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
  }


  Future<void> deleteTicketSupport(BuildContext context, int id) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    deleteTicketSupportResponse = await TicketSupportService.deleteTicketSupport(id);

    if(!context.mounted) {
      return;
    }

    if (deleteTicketSupportResponse!.success!) {
    } else {
      Utils.showCustomSnackBar(context, deleteTicketSupportResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }


  Future<void> getTicketSupportDetails(BuildContext context, int id) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    ticketSupportDetailsResponse = await TicketSupportService.getTicketSupportDetails(id);

    if(!context.mounted) {
      return;
    }

    if (ticketSupportDetailsResponse!.success!) {

      //insert description in the first index of the conversation list
      ticketSupportDetailsResponse!.conversations!.insert(0, Conversations(
        id: 0,
        customerMessage: ticketSupportDetailsResponse!.ticket!.description,
      ));


    } else {
      Utils.showCustomSnackBar(context, ticketSupportResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
  }


  Future<void> closeTicketSupport(BuildContext context, int id) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    closeTicketSupportResponse = await TicketSupportService.closeTicketSupport(id);

    if(!context.mounted) {
      return;
    }

    if (closeTicketSupportResponse!.success!) {
      Utils.showCustomSnackBar(context, closeTicketSupportResponse!.message!, ContentType.success);
    } else {
      Utils.showCustomSnackBar(context, closeTicketSupportResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
  }

  sendMessage(BuildContext context, int ticketId, String message) async {

    EasyLoading.show(status: 'loading...');
    showLoading();

    sendMessageResponse = await TicketSupportService.sendMessage(ticketId, message);

    if(!context.mounted) {
      return;
    }

    if (sendMessageResponse!.status!) {

    } else {
      Utils.showCustomSnackBar(context, sendMessageResponse!.message!, ContentType.failure);
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
