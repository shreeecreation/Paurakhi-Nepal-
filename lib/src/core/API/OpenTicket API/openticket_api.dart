import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class OpenTickets {
  static Future<http.Response?> openTicket(
      String body, String title, context) async {
    final url = Uri.parse(
        '${Environment.apiUrl}${AllAPIEndPoint.openTicketAPI}'); // Replace with your API endpoint URL
    final data = {'body': body, 'title': title};
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
        dialogComponent(context, message, Icons.check_circle, "Success");
        return response;
      } else if (code == 500) {
        var result = json.decode(response.body);
        var message = result["message"];
        dialogComponent(context, message, Icons.close, "Error");
      } else {
        var result = json.decode(response.body);
        var message = result["message"];
        dialogComponent(context, message, Icons.close, "Error");
      }
      return null;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
