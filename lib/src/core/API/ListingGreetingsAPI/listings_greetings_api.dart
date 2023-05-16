import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class ListingsGreetingsAPI {
  static Future<Map<String, dynamic>> listingsAndGreetings() async {
    final url = Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.listingsAndGreetings}'); // Replace with your API endpoint URL

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final dynamic jsonList = jsonDecode(response.body);
        print(jsonList);
        return jsonList;
      } else if (code == 400) {
      } else if (code == 500) {}
      return {};
    } catch (e) {
      print(e);
      print("dasds");
    }
    return {};
  }
}
