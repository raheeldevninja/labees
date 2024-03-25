import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

    if(!context.mounted) {
      return;
    }

    if (contactResponse.success!) {
      Utils.showCustomSnackBar(context, contactResponse.message!, ContentType.success);
      Navigator.pop(context);
    } else {
      Utils.showCustomSnackBar(context, contactResponse.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> getCompanySettings(BuildContext context) async {
    EasyLoading.show();
    showLoading();

    companySettingsResponse = await SettingsService.getCompanySettings();

    if(!context.mounted) {
      return;
    }


    if (companySettingsResponse.success!) {
    } else {
      Utils.showCustomSnackBar(context, companySettingsResponse.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> getFAQs(BuildContext context, String lang) async {
    showLoading();

    allFAQs = await SettingsService.getFAQs(lang);

    if(!context.mounted) {
      return;
    }

    if (allFAQs.success!) {
    } else {
      Utils.showCustomSnackBar(context, allFAQs.message!, ContentType.failure);
    }

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

  Future<void> getFooterSettings(BuildContext context, String lang) async {
    showLoading();

    footerSettingsResponse = await SettingsService.getFooterSettings(lang);

    if(!context.mounted) {
      return;
    }

    if (footerSettingsResponse.success!) {
    } else {
      Utils.showCustomSnackBar(context, footerSettingsResponse.message!, ContentType.failure);
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> getPageDetails(BuildContext context, String slug, String lang) async {
    EasyLoading.show();
    showLoading();

    pageDetailsResponse = await SettingsService.getPageDetails(slug, lang);

    if(!context.mounted) {
      return;
    }

    if (pageDetailsResponse!.success!) {
    } else {
      Utils.showCustomSnackBar(context, pageDetailsResponse!.message!, ContentType.failure);
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
