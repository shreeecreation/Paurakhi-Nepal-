import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/API/CookieManager/managelogincookie.dart';
import 'package:paurakhi/src/core/API/ForgotPasswordAPI/reset_pass_screen.dart';
import 'package:paurakhi/src/core/API/login/isverify.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';

class ConfirmOTP {
  static Future<bool> confirmOtp2FA(otp, context) async {
    var cookie = await ManageCookie.getOTPCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/login?otp=$otp'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        var cookieHeader = response.headers['set-cookie'];
        ManageCookie.setCookie(cookieHeader);
        IsVerify.setVerified(true);
        await GetUserInfo.getUserInfo();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          HomeRoutes.homeScreen();
        });
        return true;
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        UserDialogs.invalidOTP(context, message);
      } else if (code == 500) {}
    } catch (e) {
      return true;
    }
    return false;
  }

  static Future<bool> verifyAccount(context) async {
    var cookie = await ManageCookie.getOTPCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/account'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;

      if (code >= 200 && code < 300) {
        // IsVerify.setVerified(true);
        return true;
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        LoginDialogs.loginError(context, message);
      } else if (code == 500) {
        UserDialogs.internalServerError(context);
      }
    } catch (e) {
      return true;
    }
    return false;
  }

  static Future<bool> verifyAccountResendOtp(context) async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/account-resend'),
        headers: {
          'Cookie': ManageRegisterCookie.register_token
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        IsVerify.setVerified(true);
        AuthRoutes.loginRoute();

        return true;
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        LoginDialogs.loginError(context, message);
      } else if (code == 500) {
        UserDialogs.internalServerError(context);
      }
    } catch (e) {
      return true;
    }
    return false;
  }

  static Future<bool> verifyAccountConfirm(otp, context) async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/account?otp=$otp'),
        headers: {
          'Cookie': ManageRegisterCookie.register_token
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        IsVerify.setVerified(true);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AuthRoutes.loginRoute();
        });
        return true;
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        LoginDialogs.loginError(context, message);
      } else if (code == 500) {
        UserDialogs.internalServerError(context);
      }
    } catch (e) {
      return true;
    }
    return false;
  }

  //9801984017
  static Future<bool> resendOTP2FA(context) async {
    var cookie = await ManageCookie.getOTPCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/resend-login'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        IsVerify.setVerified(true);
        WidgetsBinding.instance.addPostFrameCallback((_) {});
        return true;
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        LoginDialogs.loginError(context, message);
      } else if (code == 500) {
        UserDialogs.internalServerError(context);
      }
    } catch (e) {
      return true;
    }
    return false;
  }

  static void confirmOtpNumberVerify(otp, context) async {
    var cookie = await ManageCookie.getOTPCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/login?otp=$otp'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        HomeRoutes.homeScreen();
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        LoginDialogs.loginError(context, message);
      } else if (code == 500) {
        UserDialogs.internalServerError(context);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Future<http.Response?> confirmOtpForgot(otp, context) async {
    var cookie = await ManageCookie.getResetCookie();
    var url =
        '${Environment.apiUrl}${AllAPIEndPoint.resetPasswordOTP}?otp=$otp';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie}, // Replace with your headers ifss needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        var cookieHeader = response.headers['set-cookie'];
        ManageCookie.setCookie(cookieHeader);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          resetPassword(context);
        });
        return response;
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        LoginDialogs.loginError(context, message);
      } else if (code == 500) {
        UserDialogs.internalServerError(context);
      }
      return null;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
