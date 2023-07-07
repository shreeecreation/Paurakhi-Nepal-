import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class CreateGrantAPI {
  static createGrant(String purpose, context, id, value) async {
    final url = Uri.parse(
        '${Environment.apiUrl}${AllAPIEndPoint.createGrant}'); // Replace with your API endpoint URL
    final data = {'id': id, 'description': purpose, 'price': value};
    var cookie = await ManageCookie.getCookie();

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
      if (code >= 200 && code < 300) {
        var result = json.decode(response.body);
        var message = result["message"];
        dialogComponent(context, message, Icons.done, "Success");
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        dialogComponent(context, message, Icons.close, "Error");
      } else if (code == 500) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          UserDialogs.internalServerError(context);
        });
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
