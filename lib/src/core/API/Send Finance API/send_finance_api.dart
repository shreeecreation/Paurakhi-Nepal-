import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/dialogs/product/product_dialog.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class SendFinanceAPI {
  static sendFinance(String purpose, context, id, value) async {
    final url = Uri.parse(
        '${Environment.apiUrl}/finance'); // Replace with your API endpoint URL
    final data = {'purpose': purpose, 'id': id, 'value': value};
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
        ProductDialogs.sucessSenduotation(context);
      } else if (code == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        dialogComponent(context, message, Icons.close, "Error");
      } else {
        UserDialogs.internalServerError(context);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
