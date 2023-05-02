import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/dialogs/login/logindialogs.dart';

class LoginEndpoints {
  static Future<http.Response?> loginPoint(String phoneNo, String password, BuildContext context) async {
    print(Environment.apiUrl);
    final url = Uri.parse('${Environment.apiUrl}/auth/user/login'); // Replace with your API endpoint URL

    final data = {'username': phoneNo, 'password': password};

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
    } else if (code == 500) {
      print("Internal server error ");
    }
    return null;
  }
}
