import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';

class LoginAPI {
  static Future<http.Response?> loginPoint(
      String phoneNo, String password, BuildContext context) async {
    final url = Uri.parse(
        '${Environment.apiUrl}/auth/user/login'); // Replace with your API endpoint URL

    final data = {'phoneNumber': phoneNo, 'password': password};
    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
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
