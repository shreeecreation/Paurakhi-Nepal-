import 'dart:convert';

import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

import 'get_product_model.dart';

class GetProductAPI {
  static Future<http.Response?> getProductSinglePage(GetProductModel model) async {
    final String filterUrl = "${Environment.apiUrl}/product/get-product?type=${model.type}&page=${model.page}&name=${model.name}";
    try {
      final response = await http.post(
        Uri.parse(filterUrl),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        return response;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {}
    return null;
  }

  static Future<List<ProductModel>?> getProductCategory(category, type) async {
    final String filterUrl = "${Environment.apiUrl}/product/get-product?type=$type&page=1&category=$category";
    List<ProductModel> products = [];
    try {
      final response = await http.get(
        Uri.parse(filterUrl),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        products = jsonList.map((dynamic json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
        return products;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {}
    return null;
  }
}
