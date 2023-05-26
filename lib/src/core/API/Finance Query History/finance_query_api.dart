import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/history/Finance%20Query%20History/model/financequery_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class FinanceEnquiryHistory {
  static Future<FinanceHistoryModel?> financeHistory() async {
    var cookie = await ManageCookie.getCookie();
    final String url = '${Environment.apiUrl}${AllAPIEndPoint.getQuotationHistoryAPI}';
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie},
      );
      var code = response.statusCode;
      print(response.body);
      if (code >= 200 && code < 300) {
        final Map<String, dynamic> jsonList = jsonDecode(response.body);
        final List<dynamic> dataList = jsonList['data'] as List<dynamic>;
        final List<Datum> items = dataList.map((item) => Datum.fromJson(item as Map<String, dynamic>)).toList();

        return FinanceHistoryModel(data: items);
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
