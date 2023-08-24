import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';

class ChangePasswordAPI {
  static Future<http.Response?> changePasword(
      String oldPass, String newPass, BuildContext context) async {
    final url = Uri.parse(
        '${Environment.apiUrl}${AllAPIEndPoint.changePasswordAPI}'); // Replace with your API endpoint URLprint
    var cookie = await ManageCookie.getCookie();

    final data = {'oldPassword': oldPass, 'newPassword': newPass};
    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookie
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;
      var result = json.decode(response.body);
      var message = result["message"];
      if (code >= 200 && code < 300) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          UserDialogs.updatePassword(context, message);
        });

        return response;
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        WidgetsBinding.instance.addPostFrameCallback((_) {
          LoginDialogs.showIncorrectPassword(context, message, "Error");
        });
      } else if (code == 500) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          UserDialogs.internalServerError(context);
        });
      }
      return null;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
