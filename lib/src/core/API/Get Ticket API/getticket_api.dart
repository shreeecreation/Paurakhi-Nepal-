import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/profile/get%20ticket/getticket_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class GetTicketHistory {
  static Future<TicketHistoryModel?> ticketHistory() async {
    var cookie = await ManageCookie.getCookie();
    final String url = '${Environment.apiUrl}${AllAPIEndPoint.getTicketHistoryAPI}';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie},
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final Map<String, dynamic> jsonList = jsonDecode(response.body);
        final List<dynamic> dataList = jsonList['data'] as List<dynamic>;
        final List<Datums> items = dataList.map((item) => Datums.fromJson(item as Map<String, dynamic>)).toList();

        return TicketHistoryModel(data: items);
      } else if (code == 400) {
        // Handle 400 error
      } else if (code == 500) {
        // Handle 500 error
      }
      return null;
    } catch (e) {
      print(e);
      // Handle exception
      return null;
    }
  }
}
