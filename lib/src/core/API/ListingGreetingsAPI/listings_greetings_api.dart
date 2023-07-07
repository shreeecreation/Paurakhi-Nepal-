import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class ListingsGreetingsAPI {
  static Future<Map<String, dynamic>> listingsAndGreetings(context) async {
    final url = Uri.parse(
        '${Environment.apiUrl}${AllAPIEndPoint.listingsAndGreetings}'); // Replace with your API endpoint URL

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json'
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final dynamic jsonList = jsonDecode(response.body);
        return jsonList;
      } else if (code == 400) {
      } else if (code == 500) {
      } else {
        const message = "Something went wrong \n Please try again later !";
        dialogComponent(context, message, Icons.close, "Error",
            button: "Restart");
      }
      return {};
    } catch (e) {
      debugPrint("$e");
    }
    return {};
  }
}
