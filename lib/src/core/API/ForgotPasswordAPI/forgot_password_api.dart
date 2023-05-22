import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/countdowntimer/countdowntimer.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/dialogs/login/logindialogs.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';

class ForgotPasswordAPI {
  static Future<http.Response?> verifyNumberForgot(String phoneNo, BuildContext context) async {
    final url = Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.resetPasswordAPI}?phoneNumber=$phoneNo'); // Replace with your API endpoint URL

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        var cookieHeader = response.headers['set-cookie'];
        CoutDownTimerManager.phoneNo = phoneNo;
        await ManageCookie.setResetCookie(cookieHeader);
        AuthRoutes.otpRouteForForgotPassword();

        return response;
      } else if (code == 400) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          LoginDialogs().showIncorrectPassword(context);
        });
      } else if (code == 500) {}
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<http.Response?> resetPassword(String newPass, BuildContext context) async {
    final url = Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.resetPassword}'); // Replace with your API endpoint URLprint
    print(url);

    
    var cookie = await ManageCookie.getCookie();

    final data = {'password': newPass};
    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        print(response.body);
        return response;
      } else if (code == 400) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          LoginDialogs().showIncorrectPassword(context);
        });
      } else if (code == 500) {}
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
