import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/models/account_data.dart';
import 'package:labees/core/models/news_letter_response.dart';
import 'package:labees/core/models/update_account_response.dart';
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
  late WalletResponse walletResponse;
  late MyPointsResponse myPointsResponse;
  late AccountSettingsResponse accountSettingsResponse;
  late ConvertToCurrencyResponse convertToCurrencyResponse;

  updateAccount(BuildContext context, AccountData accountData) async {

    EasyLoading.show(status: 'loading...');
    showLoading();

    updateAccountResponse = await AccountService.updateAccount(accountData);

    if (updateAccountResponse.success!) {

      ///update user in shared in preferences
      await SharedPref.saveUser(updateAccountResponse.user!);

      Utils.toast(updateAccountResponse.message!);

    }
    else {
      Utils.toast(updateAccountResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  newsLetter(BuildContext context, String email) async {

    EasyLoading.show(status: 'loading...');
    showLoading();

    newsLetterResponse = await AccountService.newsLetter(email);

    if (newsLetterResponse.status!) {

    }
    else {
      Utils.toast(newsLetterResponse.message!);
    }


    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }


  getWalletList(BuildContext context, int limit, int offset)  async {

    showLoading();

    walletResponse = await AccountService.getWalletList(limit, offset);

    if (walletResponse.status!) {

    }
    else {
      Utils.toast(walletResponse.message!);
    }

    hideLoading();
    notifyListeners();
  }

  getMyPoints(BuildContext context, int limit, int offset)  async {

    showLoading();

    myPointsResponse = await AccountService.getMyPoints(limit, offset);

    if (myPointsResponse.status!) {

    }
    else {
      Utils.toast(myPointsResponse.message!);
    }

    hideLoading();
    notifyListeners();
  }

  getAccountSettings(BuildContext context)  async {

    showLoading();

    accountSettingsResponse = await AccountService.getAccountSettings();

    if (accountSettingsResponse.status!) {

    }
    else {
      Utils.toast(accountSettingsResponse.message!);
    }

    hideLoading();
    notifyListeners();
  }

  convertToCurrency(BuildContext context, int point) async {

    EasyLoading.show(status: 'loading...');
    showLoading();

    convertToCurrencyResponse = await AccountService.convertToCurrency(point);

    if (convertToCurrencyResponse.status!) {
      Utils.toast(convertToCurrencyResponse.message!);
    }
    else {
      Utils.toast(convertToCurrencyResponse.message!);
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