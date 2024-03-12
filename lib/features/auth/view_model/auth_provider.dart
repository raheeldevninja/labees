import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/models/registration_response.dart';
import 'package:labees/core/models/user.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/auth/model/forgot_password_response.dart';
import 'package:labees/features/auth/model/login_response.dart';
import 'package:labees/features/auth/model/new_password_response.dart';
import 'package:labees/features/auth/model/verify_otp_response.dart';
import 'package:labees/features/auth/service/auth_service.dart';
import 'package:labees/features/home/models/registeration_data.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  late LoginResponse loginResponse;
  late ForgotPasswordResponse forgotPasswordResponse;
  late VerifyOTPResponse verifyOTPResponse;
  late NewPasswordResponse newPasswordResponse;
  late RegistrationResponse registrationResponse;
  late User user;

  bool isLoggedIn = false;

  bool get getIsLoggedIn => isLoggedIn;

  User get getUserData => user;

  AuthProvider() {
    _loadLoginState();
  }

  void setLoginStatus(bool loginStatus) {
    isLoggedIn = false;
    notifyListeners();
  }

  login(BuildContext context, String email, String password) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    loginResponse = await AuthService.login(email, password);

    print('login success: ${loginResponse.success}');

    if (loginResponse.success!) {
      isLoggedIn = true;
      await SharedPref.setLoggedIn(true);
      await SharedPref.saveUser(loginResponse.user!);
      await SharedPref.saveToken(loginResponse.token!);

      if (loginResponse.user != null) {
        log('user data saving: ${loginResponse.user!.toJson()}');
        APIs.token = loginResponse.token!;
      }

      Utils.controller.jumpToTab(0);
    } else {
      print('auth provider: ${loginResponse.message}');
      Utils.toast(loginResponse.message!);

      isLoggedIn = false;
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  register(BuildContext context, RegistrationData registrationData) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    registrationResponse = await AuthService.register(registrationData);

    if (registrationResponse.success!) {
      isLoggedIn = true;
      await SharedPref.setLoggedIn(true);
      await SharedPref.saveToken(registrationResponse.token!);

      if (registrationResponse.token != null) {
        APIs.token = registrationResponse.token!;
      }

      Utils.controller.jumpToTab(0);
    } else {
      print('auth provider: ${registrationResponse.message}');
      Utils.toast(registrationResponse.message!);

      isLoggedIn = false;
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  Future<void> logout() async {
    // Set the login state to false
    isLoggedIn = false;

    APIs.token = '';

    await SharedPref.setLoggedIn(false);
    await SharedPref.clearUser();
    //await SharedPref.clearCartProducts();
    await SharedPref.clearToken();
    await SharedPref.clearShowChooseLanguage();

    //get cart products

    notifyListeners();
  }

  Future<void> getUserInfo() async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    user = await AuthService.getUserInfo();

    if (user.success!) {
      await SharedPref.saveUser(user);
    } else {
      Utils.toast(user.message!);
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

  Future<User?> getUser() async {
    return await SharedPref.getUser();
  }

  Future<String> getToken() async {
    return await SharedPref.getToken();
  }

  Future<void> _loadLoginState() async {
    isLoggedIn = await SharedPref.isLoggedIn();
    notifyListeners();
  }

  forgotPassword(BuildContext context, String email) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    forgotPasswordResponse = await AuthService.forgotPassword(email);

    if (forgotPasswordResponse.status!) {
    } else {
      Utils.toast(forgotPasswordResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  verifyOTP(BuildContext context, String email, String otp) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    verifyOTPResponse = await AuthService.verifyOTP(email, otp);

    if (verifyOTPResponse.status!) {
    } else {
      Utils.toast(verifyOTPResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }

  setNewPassword(
      BuildContext context, String email, String otp, String password) async {
    EasyLoading.show(status: 'loading...');
    showLoading();

    newPasswordResponse =
        await AuthService.setNewPassword(email, otp, password);

    if (newPasswordResponse.status!) {
    } else {
      Utils.toast(newPasswordResponse.message!);
    }

    EasyLoading.dismiss();
    hideLoading();
    notifyListeners();
  }
}
