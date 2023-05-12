import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class ListingsGreetingsAPI {
  static Future<http.Response?> loginPoint(String phoneNo, String password, BuildContext context) async {
    final url = Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.listingsAndGreetings}'); // Replace with your API endpoint URL

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        return response;
      } else if (code == 400) {
      } else if (code == 500) {}
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
