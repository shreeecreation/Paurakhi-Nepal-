import 'dart:convert';

import 'package:paurakhi/src/app/screens/home/presentation/request/requestProductScreen/model/requestproduct_model.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class RequestProductAPI {
  static Future<http.Response?> sellProduct(RequestProductModel model) async {
    final requestModel = model;
    var cookie = await ManageCookie.getCookie();

    try {
      final response = await http.post(
        Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.createCategory}'),

        headers: {'Cookie': cookie}, // Replace with your headers if needed
        body: json.encode(requestModel.toMap()),
      );
      if (response.statusCode == 200) {
        return response;
      } else {}
    } catch (e) {}
    return null;
  }
}
