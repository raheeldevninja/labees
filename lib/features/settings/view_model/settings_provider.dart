import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/settings/contact_us_screen.dart';
import 'package:labees/features/settings/model/company_settings_response.dart';
import 'package:labees/features/settings/model/contact_response.dart';
import 'package:labees/features/settings/model/contact_store_data.dart';
import 'package:labees/features/settings/service/settings_service.dart';


class SettingsProvider extends ChangeNotifier {

  bool isLoading = false;


  bool get getIsLoading => isLoading;

  late ContactResponse contactResponse;
  late CompanySettingsResponse companySettingsResponse;

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





  showLoading() {
    isLoading = true;
    notifyListeners();
  }

  hideLoading() {
    isLoading = false;
    notifyListeners();
  }


}