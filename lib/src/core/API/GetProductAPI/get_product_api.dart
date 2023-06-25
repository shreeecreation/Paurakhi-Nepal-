import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/load_more.dart';
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

  static Future<ServerResponseProduct?> getProductCategory(category, type, page) async {
    String filterUrl = "";
    if (category != "") {
      filterUrl = "${Environment.apiUrl}/product/get-product?type=$type&page=$page&category=$category";
    } else {
      filterUrl = "${Environment.apiUrl}/product/get-product?type=$type&page=$page";
    }
    try {
      final response = await http.get(
        Uri.parse(filterUrl),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final Map<String, dynamic> jsonList = jsonDecode(response.body);
        final List<dynamic> dataList = jsonList['data'] as List<dynamic>;
        final List<ProductModel> items = dataList.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
        LoadMore.model = [];
        LoadMore.model = items;
        return ServerResponseProduct(data: items);
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
