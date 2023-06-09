import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class BlogNewsFinanceAPI {
  static Future<List<BlogModelNewsFinanceModel>?> getAPI(type, page) async {
    var cookie = await ManageCookie.getCookie();
    final String url = '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}?type=$type&page=$page';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      print(response.body);
      final List<dynamic> jsonList = jsonDecode(response.body);
      List<BlogModelNewsFinanceModel> blogs = [];
      blogs = jsonList.map((dynamic json) => BlogModelNewsFinanceModel.fromJson(json as Map<String, dynamic>)).toList();
      return blogs;
    } catch (e) {
      print('asdasdas');
      print(e);
    }
    return null;
  }
}
