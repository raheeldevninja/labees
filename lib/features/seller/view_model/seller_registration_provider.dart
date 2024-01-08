import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/seller/model/seller_registration_data.dart';
import 'package:labees/features/seller/model/seller_registration_response.dart';
import 'package:labees/features/seller/service/seller_registration_service.dart';

class SellerRegistrationProvider extends ChangeNotifier {

  bool isLoading = false;

  bool get getIsLoading => isLoading;

  late SellerRegistrationResponse sellerRegistrationResponse;

  File? crFreelanceDocFile;
  File? logoFile;
  File? bannerFile;
  File? additionalDocFile;
  File? image;

  setCRFreelanceDocFile(File file) {
    crFreelanceDocFile = file;
    notifyListeners();
  }

  File? get getCRFreelanceDocFile => crFreelanceDocFile;

  setLogoFile(File file) {
    logoFile = file;
    notifyListeners();
  }

  File? get getLogoFile => logoFile;

  setBannerFile(File file) {
    bannerFile = file;
    notifyListeners();
  }

  File? get getBannerFile => bannerFile;

  setAdditionalDocFile(File file) {
    additionalDocFile = file;
    notifyListeners();
  }

  File? get getAdditionalDocFile => additionalDocFile;

  setImage(File file) {
    image = file;
    notifyListeners();
  }

  File? get getImage => image;


  sellerRegister(BuildContext context, SellerRegistrationData sellerRegistrationData) async {

    EasyLoading.show(status: 'loading...');
    showLoading();

    sellerRegistrationResponse = await SellerRegistrationService.sellerRegister(sellerRegistrationData);

    if (sellerRegistrationResponse.success!) {
      Utils.toast(sellerRegistrationResponse.message!);

      Navigator.pop(context);
    }
    else {
      Utils.toast(sellerRegistrationResponse.message!);
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