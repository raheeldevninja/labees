import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/settings/model/AllFAQs.dart';
import 'package:labees/features/settings/model/company_settings_response.dart';
import 'package:labees/features/settings/model/contact_response.dart';
import 'package:labees/features/settings/model/contact_store_data.dart';
import 'package:labees/features/settings/model/footer_settings_response.dart';
import 'package:labees/features/settings/model/page_details_response.dart';
import 'package:labees/features/settings/service/settings_service.dart';

import '../model/faqs_response.dart';


class SettingsProvider extends ChangeNotifier {

  bool isLoading = false;


  bool get getIsLoading => isLoading;

  late ContactResponse contactResponse;
  late CompanySettingsResponse companySettingsResponse;
  late FooterSettingsResponse footerSettingsResponse;
  PageDetailsResponse? pageDetailsResponse;
  late AllFAQs allFAQs;

  contactUs(BuildContext context, ContactStoreData contactStoreData) async {

    EasyLoading.show(status: 'loading...');
    showLoading();


    contactResponse = await SettingsService.contactUs(contactStoreData);

    if (contactResponse.success!) {

      Utils.toast(contactResponse.message!);
      Navigator.pop(context);

    }
    else {
      Utils.toast(contactResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> getCompanySettings() async {

    EasyLoading.show();
    showLoading();


    companySettingsResponse = await SettingsService.getCompanySettings();

    if (companySettingsResponse.success!) {

    } else {
      Utils.toast(companySettingsResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }


  Future<void> getFAQs(String lang) async {

    EasyLoading.show();
    showLoading();

    allFAQs = await SettingsService.getFAQs(lang);

    if (allFAQs.success!) {

    } else {
      Utils.toast(allFAQs.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }


  //set faq expansion tile status
  void setFAQExpansionTileStatus(int index, bool isExpanded) {
    allFAQs.faqsResponse![index].isExpanded = isExpanded;

    for (int i = 0; i < allFAQs.faqsResponse!.length; i++) {
      if (i != index) {
        allFAQs.faqsResponse![i].isExpanded = false;
      }
    }

    notifyListeners();
  }

  Future<void> getFooterSettings() async {

    EasyLoading.show();
    showLoading();


    footerSettingsResponse = await SettingsService.getFooterSettings();

    if (footerSettingsResponse.success!) {

    } else {
      Utils.toast(footerSettingsResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> getPageDetails(String slug) async {

    EasyLoading.show();
    showLoading();


    pageDetailsResponse = await SettingsService.getPageDetails(slug);

    if (pageDetailsResponse!.success!) {

    } else {
      Utils.toast(pageDetailsResponse!.message!);
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