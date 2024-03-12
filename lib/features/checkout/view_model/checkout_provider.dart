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

  Future<void> getCountries() async {
    showLoading();

    countries = await CheckoutService.getCountries();

    if (countries.success) {
      countriesData = countries.data!;
    } else {
      Utils.toast(countries.message!);
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> getCities(int countryId) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    // cities = Cities();
    // citiesData = [];

    cities = await CheckoutService.getCities(countryId);

    if (cities!.success) {
      citiesData = cities!.data!;
    } else {
      Utils.toast(cities!.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  addAddress(BuildContext context, AddressModel addressModel) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    addAddressResponse = await CheckoutService.addAddress(addressModel);

    if (addAddressResponse!.success!) {
    } else {
      Utils.toast(addAddressResponse!.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  updateAddress(BuildContext context, AddressModel addressModel) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    updateAddressResponse = await CheckoutService.updateAddress(addressModel);

    if (updateAddressResponse!.success!) {
    } else {
      Utils.toast(updateAddressResponse!.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> getAllAddresses() async {
    showLoading();

    print('token getAllAddresses(): ${APIs.token}');
    if(APIs.token == '') {
      return;
    }

    allAddresses = await CheckoutService.getAllAddresses();

    if (allAddresses != null && allAddresses!.success!) {
      addressData = allAddresses!.addresses!;
    } else {
      Utils.toast(cities?.message ?? 'Error');
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> updateDefaultAddress(int id) async {
    EasyLoading.show(status: 'loading...');
    showLoading();
    defaultAddressResponse = await CheckoutService.updateDefaultAddress(id);

    if (defaultAddressResponse!.status!) {
    } else {
      Utils.toast(defaultAddressResponse!.message!);
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

  Future<void> placeOrder(PlaceOrderModel placeOrderModel) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    placeOrderResponse = await CheckoutService.placeOrder(placeOrderModel);

    if (placeOrderResponse!.status == 1) {
    } else {
      Utils.toast(placeOrderResponse!.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> deleteAddress(int id) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    deleteAddressResponse = await CheckoutService.deleteAddress(id);
    await CheckoutService.getAllAddresses();

    if (deleteAddressResponse!.success!) {
    } else {
      Utils.toast(deleteAddressResponse!.message!);
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

  Future<void> getNotifications() async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    notificationsResponse = await CheckoutService.getNotifications();

    if (notificationsResponse!.success) {
      notifications = notificationsResponse!.notifications!;
    } else {
      Utils.toast(notificationsResponse!.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
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
