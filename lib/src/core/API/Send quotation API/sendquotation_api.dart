import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/dialogs/product/product_dialog.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class SendQuotationAPI {
  static sendQuotation(String quantity, context, id) async {
    final url = Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.sendQuotationAPI}'); // Replace with your API endpoint URL
    print(url);
    final data = {'quantity': quantity, 'id': id};
    var cookie = await ManageCookie.getCookie();

    try {
      final response = await http.post(
        url,

        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      print(code);
      print(response.body);
      if (code >= 200 && code < 300) {
        ProductDialogs.sucessSenduotation(context);
      } else if (code == 500) {}
    } catch (e) {
      print(e);
    }
  }
}
