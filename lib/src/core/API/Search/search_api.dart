import 'dart:convert';

import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

class SearchAPI {
  static Future<ServerResponseProduct?> getSearchedProduct(category, name, type) async {
    final finalName = name == "" ? "" : "name=$name&";
    final finalType = "type=$type&";
    final finalCategory = category.isEmpty ? "" : "category=$category&";

    String url = '${Environment.apiUrl}${AllAPIEndPoint.searchAPI}$finalName$finalCategory$finalType';
    print(url);
    final filteredUrl = url.substring(0, url.length - 1);
    final finalUrl = Uri.parse(filteredUrl); // Replace with your API endpoint URL
    try {
      final response = await http.get(
        finalUrl,
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final Map<String, dynamic> jsonList = jsonDecode(response.body);
        final List<dynamic> dataList = jsonList['data'] as List<dynamic>;
        final List<ProductModel> items = dataList.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
        print(items);
        return ServerResponseProduct(data: items);
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<BlogModelNewsFinanceModel>?> getSearchedBlog(title) async {
    String url = '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?title=$title&type=blog';
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      print(code);
      if (code >= 200 && code < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<BlogModelNewsFinanceModel> products = [];

        products = jsonList.map((dynamic json) => BlogModelNewsFinanceModel.fromJson(json as Map<String, dynamic>)).toList();
        return products;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {}
    return null;
  }

  static Future<List<BlogModelNewsFinanceModel>?> getSearchedNews(title) async {
    String url = '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?title=$title&type=news';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      print(code);
      if (code >= 200 && code < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<BlogModelNewsFinanceModel> products = [];

        products = jsonList.map((dynamic json) => BlogModelNewsFinanceModel.fromJson(json as Map<String, dynamic>)).toList();
        return products;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {}
    return null;
  }

  static Future<List<BlogModelNewsFinanceModel>?> getSearchedFinance(title) async {
    String url = '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?title=$title&type=finance';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      print(code);
      if (code >= 200 && code < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<BlogModelNewsFinanceModel> products = [];

        products = jsonList.map((dynamic json) => BlogModelNewsFinanceModel.fromJson(json as Map<String, dynamic>)).toList();
        return products;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {}
    return null;
  }
}
