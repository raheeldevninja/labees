import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/models/account_data.dart';
import 'package:labees/core/models/news_letter_response.dart';
import 'package:labees/core/models/update_account_response.dart';
import 'package:labees/core/models/update_newsletter_response.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/service/account_service.dart';
import 'package:labees/features/home/pages/account_page/model/account_settings_response.dart';
import 'package:labees/features/home/pages/account_page/model/convert_currency_response.dart';
import 'package:labees/features/home/pages/account_page/model/my_points_response.dart';
import 'package:labees/features/home/pages/account_page/model/wallet_response.dart';

/*
*  Date 12 - Now-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: AccountProvider
*/

class AccountProvider extends ChangeNotifier {
  bool isLoading = false;

  late UpdateAccountResponse updateAccountResponse;
  late NewsLetterResponse newsLetterResponse;
  UpdateNewsletterResponse? updateNewsletterResponse;
  late WalletResponse walletResponse;
  MyPointsResponse? myPointsResponse;
  late AccountSettingsResponse accountSettingsResponse;
  late ConvertToCurrencyResponse convertToCurrencyResponse;

  updateAccount(BuildContext context, AccountData accountData) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    updateAccountResponse = await AccountService.updateAccount(accountData);

    if(!context.mounted) {
      return;
    }

    if (updateAccountResponse.success!) {
      ///update user in shared in preferences
      await SharedPref.saveUser(updateAccountResponse.user!);

      Utils.showCustomSnackBar(context, updateAccountResponse.message!, ContentType.success);
    } else {
      Utils.showCustomSnackBar(context, updateAccountResponse.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  newsLetter(BuildContext context, String email) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    newsLetterResponse = await AccountService.newsLetter(email);

    if(!context.mounted) {
      return;
    }

    if (newsLetterResponse.status!) {
    } else {
      Utils.showCustomSnackBar(context, newsLetterResponse.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> updateNewsletter(BuildContext context, int status) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    updateNewsletterResponse = await AccountService.updateNewsletter(status);

    if(!context.mounted) {
      return;
    }

    if (updateNewsletterResponse!.status!) {
      await SharedPref.saveUser(updateNewsletterResponse!.user!);
      Utils.showCustomSnackBar(context, updateNewsletterResponse!.message!, ContentType.success);
    } else {
      Utils.showCustomSnackBar(context, updateNewsletterResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
  }

  getWalletList(BuildContext context, int limit, int offset) async {
    showLoading();

    walletResponse = await AccountService.getWalletList(limit, offset);

    print('statusss ${walletResponse.status}');

    if(!context.mounted) {
      return;
    }

    if (walletResponse.status!) {
    } else {
      Utils.showCustomSnackBar(context, walletResponse.message!, ContentType.failure);
    }

    hideLoading();
  }

  Future<void> getMyPoints(BuildContext context, int limit, int offset) async {
    showLoading();

    myPointsResponse = await AccountService.getMyPoints(limit, offset);

    if(!context.mounted) {
      return;
    }

    if (myPointsResponse!.status!) {
    } else {
      Utils.showCustomSnackBar(context, myPointsResponse!.message!, ContentType.failure);
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> getAccountSettings(BuildContext context) async {
    showLoading();

    accountSettingsResponse = await AccountService.getAccountSettings();

    if(!context.mounted) {
      return;
    }

    if (accountSettingsResponse.status!) {
    } else {
      Utils.showCustomSnackBar(context, accountSettingsResponse.message!, ContentType.failure);
    }

    hideLoading();
    notifyListeners();
  }

  convertToCurrency(BuildContext context, int point) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    convertToCurrencyResponse = await AccountService.convertToCurrency(point);

    if(!context.mounted) {
      return;
    }

    if (convertToCurrencyResponse.status!) {
      Utils.showCustomSnackBar(context, convertToCurrencyResponse.message!, ContentType.success);
    } else {
      Utils.showCustomSnackBar(context, convertToCurrencyResponse.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  bool get getLoading => isLoading;

  showLoading() {
    isLoading = true;
    notifyListeners();
  }

  hideLoading() {
    isLoading = false;
    notifyListeners();
  }
}
