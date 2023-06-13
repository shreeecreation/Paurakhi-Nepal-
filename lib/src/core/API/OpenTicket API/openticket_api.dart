import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/dialogs/ticket/ticket_dialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class OpenTickets {
  static Future<http.Response?> openTicket(String body, String title, context) async {
    final url = Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.openTicketAPI}'); // Replace with your API endpoint URL
    print(url);
    final data = {'body': body, 'title': title};
    var cookie = await ManageCookie.getCookie();

    try {
      final response = await http.post(
        url,

        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      print(response.body);
      if (code >= 200 && code < 300) {
        OpenTicketDialogs.successCreateTicket(context);
        return response;
      } else if (code == 500) {}
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
