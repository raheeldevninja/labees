import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/models/registration_response.dart';
import 'package:labees/core/models/user.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/auth/model/forgot_password_response.dart';
import 'package:labees/features/auth/model/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:labees/features/auth/model/new_password_response.dart';
import 'package:labees/features/auth/model/verify_otp_response.dart';
import 'package:labees/features/home/models/registeration_data.dart';

class AuthService {
  static Future<LoginResponse> login(String email, String password) async {
    LoginResponse loginResponse;
    String url = APIs.baseURL + APIs.login;

    try {
      var body = {'email': email, 'password': password};

      print('url: $url');
      print('body: ${body.toString()}');

      var response =
          await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print('Response status: ${response.statusCode}');
      print('login response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('login response: ${response.statusCode}');
        loginResponse = LoginResponse.fromJson(result);
        loginResponse.success = true;
        loginResponse.message = 'Success';
        return loginResponse;
      } else if (response.statusCode == 401) {
        return LoginResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return LoginResponse(success: false, message: 'Server Error');
      } else {
        return LoginResponse(success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return LoginResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return LoginResponse(success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return LoginResponse(success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<RegistrationResponse> register(
      RegistrationData registrationData) async {
    RegistrationResponse registrationResponse;
    String url = APIs.baseURL + APIs.register;

    try {
      /*var body = {
        'email': email,
        'password': password
      };*/

      print('registration url: $url');
      print('body: ${registrationData.toString()}');

      var response = await http.post(Uri.parse(url),
          body: jsonEncode(registrationData.toMap()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      print('Response status: ${response.statusCode}');
      print('registration response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        registrationResponse = RegistrationResponse.fromJson(result);
        registrationResponse.success = true;
        registrationResponse.message = 'Success';
        return registrationResponse;
      } else if (response.statusCode == 401) {
        return RegistrationResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 403) {
        return RegistrationResponse(
            success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return RegistrationResponse(success: false, message: 'Server Error');
      } else {
        return RegistrationResponse(
            success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return RegistrationResponse(
          success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return RegistrationResponse(success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return RegistrationResponse(
          success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<User> getUserInfo() async {
    User user;
    String url = APIs.baseURL + APIs.getUerInfo;

    try {
      print('url: $url');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${APIs.token}'
      });

      print('Response status: ${response.statusCode}');
      log('token: ${APIs.token}');
      print('user info response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        user = User.fromJson(result);

        user.success = true;
        user.message = 'Success';

        return user;
      } else if (response.statusCode == 401) {
        return User(success: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return User(success: false, message: 'Server Error');
      } else {
        return User(success: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return User(success: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return User(success: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return User(success: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<ForgotPasswordResponse> forgotPassword(String email) async {
    ForgotPasswordResponse forgotPasswordResponse;
    String url = APIs.baseURL + APIs.forgotPassword;

    try {
      var body = {'identity': email};

      print('url: $url');
      print('body: ${body.toString()}');

      var response =
          await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print('Response status: ${response.statusCode}');
      print('forgot password response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        forgotPasswordResponse = ForgotPasswordResponse.fromJson(result);
        forgotPasswordResponse.status = true;
        forgotPasswordResponse.message = 'Success';
        return forgotPasswordResponse;
      } else if (response.statusCode == 401) {
        return ForgotPasswordResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 404) {
        return ForgotPasswordResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return ForgotPasswordResponse(status: false, message: 'Server Error');
      } else {
        return ForgotPasswordResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return ForgotPasswordResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return ForgotPasswordResponse(status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return ForgotPasswordResponse(
          status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<VerifyOTPResponse> verifyOTP(String email, String otp) async {
    VerifyOTPResponse verifyOTPResponse;
    String url = APIs.baseURL + APIs.verifyOTP;

    try {
      var body = {'identity': email, 'otp': otp};

      print('url: $url');
      print('body: ${body.toString()}');

      var response =
          await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print('Response status: ${response.statusCode}');
      print('verify otp response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        verifyOTPResponse = VerifyOTPResponse.fromJson(result);
        verifyOTPResponse.status = true;
        verifyOTPResponse.message = 'Success';
        return verifyOTPResponse;
      } else if (response.statusCode == 401) {
        return VerifyOTPResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 404) {
        return VerifyOTPResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return VerifyOTPResponse(status: false, message: 'Server Error');
      } else {
        return VerifyOTPResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return VerifyOTPResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return VerifyOTPResponse(status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return VerifyOTPResponse(status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<NewPasswordResponse> setNewPassword(
      String email, String otp, String password) async {
    NewPasswordResponse newPasswordResponse;
    String url =
        '${APIs.baseURL}${APIs.resetPassword}?identity=$email&otp=$otp&password=$password';

    try {
      var body = {
        'identity': email,
        'otp': otp,
        'password': password,
      };

      print('url: $url');
      print('body: ${body.toString()}');

      var response = await http.put(Uri.parse(url),
          //body: jsonEncode(body),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      print('Response status: ${response.statusCode}');
      print('new password response: ${response.body}');

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        newPasswordResponse = NewPasswordResponse.fromJson(result);
        newPasswordResponse.status = true;
        newPasswordResponse.message = 'Success';
        return newPasswordResponse;
      } else if (response.statusCode == 401) {
        return NewPasswordResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 400) {
        return NewPasswordResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 404) {
        return NewPasswordResponse(
            status: false, message: result['errors'][0]['message']);
      } else if (response.statusCode == 500) {
        return NewPasswordResponse(status: false, message: 'Server Error');
      } else {
        return NewPasswordResponse(
            status: false, message: 'Something went wrong !');
      }
    } on SocketException {
      return NewPasswordResponse(
          status: false, message: 'Not connect to internet !');
    } on TimeoutException catch (e) {
      return NewPasswordResponse(status: false, message: 'Request timeout');
    } on FormatException catch (e) {
      return NewPasswordResponse(status: false, message: 'Bad response format');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
