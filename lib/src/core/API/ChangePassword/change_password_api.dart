import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/dialogs/login/logindialogs.dart';

class ChangePasswordAPI {
  static Future<http.Response?> changePasword(String oldPass, String newPass, BuildContext context) async {
    final url = Uri.parse('${Environment.apiUrl}/auth/user/login'); // Replace with your API endpoint URL

    final data = {'oldPass': oldPass, 'newPass': newPass};
    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode; 
      if (code >= 200 && code < 300) {
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
