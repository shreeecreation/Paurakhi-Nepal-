import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

import 'get_product_model.dart';

class GetProductAPI {
  static Future<http.Response?> getProduct(GetProductModel model) async {

    final String filterUrl = "${Environment.apiUrl}/product/get-product?type=${model.type}&page=${model.page}&name=${model.name}";
    final String noFilterUrl = "${Environment.apiUrl}/product/get-product?type=request&page=${model.page}";
    try {
      final response = await http.post(
        Uri.parse(filterUrl),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        print(response);
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
