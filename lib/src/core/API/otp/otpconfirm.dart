import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CheckLogin/check_login.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/API/ForgotPasswordAPI/reset_pass_screen.dart';
import 'package:paurakhi/src/core/API/login/isverify.dart';
import 'package:paurakhi/src/core/dialogs/auth/logindialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';

class ConfirmOTP {
  static Future<bool> confirmOtp2FA(otp) async {
    var cookie = await ManageCookie.getOTPCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/login?otp=$otp'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        IsVerify.setVerified(true);
        return true;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      return true;
    }
    return false;
  }
  //9801984017

  static void confirmOtpNumberVerify(otp) async {
    var cookie = await ManageCookie.getOTPCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/login?otp=$otp'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        CheckLogin.setLoginInValue(true);
        HomeRoutes.homeScreen();
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      print("Error");
    }
  }

  static Future<http.Response?> confirmOtpForgot(otp, context) async {
    var cookie = await ManageCookie.getResetCookie();
    var url = '${Environment.apiUrl}${AllAPIEndPoint.resetPasswordOTP}?otp=$otp';
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
      } else if (code == 500) {}
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
