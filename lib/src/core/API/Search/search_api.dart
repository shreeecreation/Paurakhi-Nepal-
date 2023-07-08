import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchAPI {
  static Future<ServerResponseProduct?> getSearchedProduct(
      name, type, context, page) async {
    final finalName = name == "" ? "" : "name=$name&";
    final finalType = "type=$type&";
    String finalCategory = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? numbersJson = prefs.getStringList('checkedValues');
    String result = "";
    if (numbersJson != null) {
      result = numbersJson.join(',');
      if (name == "") {
        finalCategory = "";
      } else {
        finalCategory = "category=$result&";
      }
    }

    String url =
        '${Environment.apiUrl}${AllAPIEndPoint.searchAPI}$finalName$finalCategory${finalType}page=$page&';
    final filteredUrl = url.substring(0, url.length - 1);
    final finalUrl =
        Uri.parse(filteredUrl); // Replace with your API endpoint URL
    try {
      final response = await http.get(
        finalUrl,
        headers: {
          'Content-Type': 'application/json'
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final Map<String, dynamic> jsonList = jsonDecode(response.body);
        final List<dynamic> dataList = jsonList['data'] as List<dynamic>;
        final List<ProductModel> items = dataList
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return ServerResponseProduct(data: items);
      } else if (code == 400) {
      } else if (code == 500) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          UserDialogs.internalServerError(context);
        });
      }
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  static Future<List<BlogModelNewsFinanceModel>?> getSearchedBlog(title) async {
    String url =
        '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?title=$title&type=blog';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<BlogModelNewsFinanceModel> products = [];

        products = jsonList
            .map((dynamic json) => BlogModelNewsFinanceModel.fromJson(
                json as Map<String, dynamic>))
            .toList();
        return products;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  static Future<List<BlogModelNewsFinanceModel>?> getSearchedNews(title) async {
    String url =
        '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?title=$title&type=news';
    if (title == "") {
      url = '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?type=news';
    }

    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;

      if (code >= 200 && code < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<BlogModelNewsFinanceModel> products = [];

        products = jsonList
            .map((dynamic json) => BlogModelNewsFinanceModel.fromJson(
                json as Map<String, dynamic>))
            .toList();
        return products;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  static Future<List<BlogModelNewsFinanceModel>?> getSearchedFinance(
      title) async {
    String url =
        '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?title=$title&type=finance';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;

      if (code >= 200 && code < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<BlogModelNewsFinanceModel> products = [];

        products = jsonList
            .map((dynamic json) => BlogModelNewsFinanceModel.fromJson(
                json as Map<String, dynamic>))
            .toList();
        return products;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }

  static Future<List<BlogModelNewsFinanceModel>?> getSearchedGrants(
      title) async {
    String url =
        '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?title=$title&type=grant';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;

      if (code >= 200 && code < 300) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        List<BlogModelNewsFinanceModel> products = [];

        products = jsonList
            .map((dynamic json) => BlogModelNewsFinanceModel.fromJson(
                json as Map<String, dynamic>))
            .toList();
        return products;
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
