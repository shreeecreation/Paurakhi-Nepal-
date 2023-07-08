import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/dialogs/product/product_dialog.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class SendQuotationAPI {
  static sendQuotation(String quantity, context, id) async {
    final url = Uri.parse(
        '${Environment.apiUrl}${AllAPIEndPoint.sendQuotationAPI}'); // Replace with your API endpoint URL
    final data = {'quantity': quantity, 'id': id};
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
      } else if (code == 500) {
        UserDialogs.internalServerError(context);
      } else {
        var result = json.decode(response.body);
        var message = result["message"];
        ProductDialogs.failureSenduotation(context, message);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
