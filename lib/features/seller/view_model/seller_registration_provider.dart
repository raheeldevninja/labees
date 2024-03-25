import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/models/product.dart';
import 'package:labees/features/seller/model/seller_products_response.dart';
import 'package:labees/features/seller/model/seller_profile_response.dart';
import 'package:labees/features/seller/model/seller_registration_data.dart';
import 'package:labees/features/seller/model/seller_registration_response.dart';
import 'package:labees/features/seller/service/seller_registration_service.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';


class SellerRegistrationProvider extends ChangeNotifier {
  bool isLoading = false;

  bool get getIsLoading => isLoading;

  late SellerRegistrationResponse sellerRegistrationResponse;

  SellerProfileResponse? sellerProfileResponse;
  SellerProductsResponse? sellerProductsResponse;

  List<Products>? sellerProducts = [];

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

  sellerRegister(BuildContext context,
      SellerRegistrationData sellerRegistrationData) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    sellerRegistrationResponse =
        await SellerRegistrationService.sellerRegister(sellerRegistrationData);

    if(!context.mounted) {
      return;
    }

    if (sellerRegistrationResponse.success!) {
      Utils.showCustomSnackBar(context, sellerRegistrationResponse.message!, ContentType.success);

      Navigator.pop(context);
    } else {
      Utils.showCustomSnackBar(context, sellerRegistrationResponse.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }


  Future<void> getSellerProfile(BuildContext context, int sellerId) async {

    showLoading();

    sellerProfileResponse = await SellerRegistrationService.getSellerProfile(sellerId);

    if(!context.mounted) {
      return;
    }

    if (sellerProfileResponse!.success!) {

    } else {
      Utils.showCustomSnackBar(context, sellerProfileResponse!.message!, ContentType.failure);
    }


    hideLoading();
    notifyListeners();
  }


  Future<void> getSellerProducts(BuildContext context, int sellerId, int limit, int offset, String search) async {


    showLoading();

    sellerProductsResponse = await SellerRegistrationService.getSellerProducts(sellerId, limit, offset, search);

    if(!context.mounted) {
      return;
    }

    if (sellerProductsResponse!.success!) {
      sellerProducts = sellerProductsResponse!.products;
    } else {
      Utils.showCustomSnackBar(context, sellerProductsResponse!.message!, ContentType.failure);
    }


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
