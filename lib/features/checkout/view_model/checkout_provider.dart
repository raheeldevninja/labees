import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/models/add_address_response.dart';
import 'package:labees/core/models/address_data.dart';
import 'package:labees/core/models/all_addresses.dart';
import 'package:labees/core/models/cities_data.dart';
import 'package:labees/core/models/countries_data.dart';
import 'package:labees/core/models/default_address_response.dart';
import 'package:labees/core/models/delete_address_response.dart';
import 'package:labees/core/models/notifications_response.dart';
import 'package:labees/core/models/place_order_model.dart';
import 'package:labees/core/models/place_order_response.dart';
import 'package:labees/core/models/update_address_response.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/checkout/service/checkout_service.dart';
import 'package:labees/features/home/models/address_data.dart';

class CheckoutProvider extends ChangeNotifier {
  bool isLoading = false;

  bool get getIsLoading => isLoading;

  late Countries countries;
  late List<CountriesData> countriesData;

  Cities? cities;
  late List<CitiesData> citiesData;

  //late AllAddresses allAddresses;
  AllAddresses? allAddresses;
  PlaceOrderResponse? placeOrderResponse;
  DeleteAddressResponse? deleteAddressResponse;
  DefaultAddressResponse? defaultAddressResponse;

  late List<AddressData> addressData;

  AddAddressResponse? addAddressResponse;
  UpdateAddressResponse? updateAddressResponse;

  int? billingAddressId;
  int? shippingAddressId;

  NotificationsResponse? notificationsResponse;
  late List<Notifications> notifications;

  int? get getBillingAddressId => billingAddressId;

  setBillingAddressId(int? billingAddressId) {
    this.billingAddressId = billingAddressId;
    notifyListeners();
  }

  int? get getShippingAddressId => shippingAddressId;

  setShippingAddressId(int? shippingAddressId) {
    this.shippingAddressId = shippingAddressId;
    notifyListeners();
  }

  PlaceOrderModel placeOrderModel = PlaceOrderModel();

  PlaceOrderModel get getPlaceOrderModel => placeOrderModel;

  setPlaceOrderModel(PlaceOrderModel placeOrderModel) {
    this.placeOrderModel = placeOrderModel;
    notifyListeners();
  }

  Future<void> getCountries(BuildContext context) async {
    showLoading();

    countries = await CheckoutService.getCountries();

    if(!context.mounted) {
      return;
    }

    if (countries.success) {
      countriesData = countries.data!;
    } else {
      Utils.showCustomSnackBar(context, countries.message!, ContentType.failure);
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> getCities(BuildContext context, int countryId) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    // cities = Cities();
    // citiesData = [];

    cities = await CheckoutService.getCities(countryId);

    if(!context.mounted) {
      return;
    }

    if (cities!.success) {
      citiesData = cities!.data!;
    } else {
      Utils.showCustomSnackBar(context, cities!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  addAddress(BuildContext context, AddressModel addressModel) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    addAddressResponse = await CheckoutService.addAddress(addressModel);

    if(!context.mounted) {
      return;
    }

    if (addAddressResponse!.success!) {
    } else {
      Utils.showCustomSnackBar(context, addAddressResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  updateAddress(BuildContext context, AddressModel addressModel) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    updateAddressResponse = await CheckoutService.updateAddress(addressModel);

    if(!context.mounted) {
      return;
    }

    if (updateAddressResponse!.success!) {
    } else {
      Utils.showCustomSnackBar(context, updateAddressResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> getAllAddresses(BuildContext context) async {
    showLoading();

    print('token getAllAddresses(): ${APIs.token}');
    if(APIs.token == '') {
      return;
    }

    allAddresses = await CheckoutService.getAllAddresses();

    if(!context.mounted) {
      return;
    }

    if (allAddresses != null && allAddresses!.success!) {
      addressData = allAddresses!.addresses!;
    } else {
      Utils.showCustomSnackBar(context, cities?.message ?? 'Error', ContentType.failure);
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> updateDefaultAddress(BuildContext context, int id) async {
    EasyLoading.show(status: 'loading...');
    showLoading();
    defaultAddressResponse = await CheckoutService.updateDefaultAddress(id);

    if (defaultAddressResponse!.status!) {
    } else {
      Utils.showCustomSnackBar(context, defaultAddressResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  bool checkAddressesHaveBillingAddress() {
    for (int i = 0; i < allAddresses!.addresses!.length; i++) {
      if (allAddresses!.addresses![i].isBilling == 1) {
        return true;
      }
    }

    return false;
  }

  int getFirstBillingAddressIndex() {
    for (int i = 0; i < allAddresses!.addresses!.length; i++) {
      if (allAddresses!.addresses![i].isBilling == 1) {
        return i;
      }
    }

    return -1;
  }

  bool checkAddressesHaveShippingAddress() {
    for (int i = 0; i < allAddresses!.addresses!.length; i++) {
      if (allAddresses!.addresses![i].isBilling == 0) {
        return true;
      }
    }

    return false;
  }

  int getFirstShippingAddressIndex() {
    for (int i = 0; i < allAddresses!.addresses!.length; i++) {
      if (allAddresses!.addresses![i].isBilling == 0) {
        return i;
      }
    }

    return -1;
  }

  Future<void> placeOrder(BuildContext context, PlaceOrderModel placeOrderModel) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    placeOrderResponse = await CheckoutService.placeOrder(placeOrderModel);

    if(!context.mounted) {
      return;
    }

    if (placeOrderResponse!.status == 1) {
    } else {
      Utils.showCustomSnackBar(context, placeOrderResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> deleteAddress(BuildContext context, int id) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    deleteAddressResponse = await CheckoutService.deleteAddress(id);
    await CheckoutService.getAllAddresses();

    if (deleteAddressResponse!.success!) {
    } else {
      Utils.showCustomSnackBar(context, deleteAddressResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  List<CountriesData> originalCountriesData = [];

  void searchCountry(String query) {
    if (originalCountriesData.isEmpty) {
      originalCountriesData = countriesData.toList();
    }

    if (query.isNotEmpty) {
      List<CountriesData> listData = [];
      originalCountriesData.forEach((item) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          listData.add(item);
        }
      });
      countriesData.clear();
      countriesData.addAll(listData);
    } else {
      countriesData.clear();
      countriesData.addAll(
          originalCountriesData); // Restore original data when query is empty
    }
    notifyListeners();
  }

  List<CitiesData> originalCitiesData = [];

  void searchCity(String query) {
    if (originalCitiesData.isEmpty) {
      originalCitiesData = cities!.data!.toList();
    }

    if (query.isNotEmpty) {
      List<CitiesData> listData = [];
      originalCitiesData.forEach((item) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          listData.add(item);
        }
      });
      citiesData.clear();
      citiesData.addAll(listData);
    } else {
      cities!.data!.clear();
      cities!.data!.addAll(
          originalCitiesData); // Restore original data when query is empty
    }
    notifyListeners();
  }

  Future<void> getNotifications(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    notificationsResponse = await CheckoutService.getNotifications();

    if(!context.mounted) {
      return;
    }

    if (notificationsResponse!.success) {
      notifications = notificationsResponse!.notifications!;
    } else {
      Utils.showCustomSnackBar(context, notificationsResponse!.message!, ContentType.failure);
    }

    EasyLoading.dismiss();
    hideLoading();
  }

  clearAllAddresses() {
    allAddresses = null;
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    countries = Countries();
    countriesData = [];

    cities = null;
    citiesData = [];
  }
}
