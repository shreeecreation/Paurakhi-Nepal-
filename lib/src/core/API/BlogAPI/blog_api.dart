import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class BlogAPI {
  static Future<List<BlogModel>?> getBlog() async {
    var cookie = await ManageCookie.getCookie();
    final String url = '${Environment.apiUrl}/${AllAPIEndPoint.blogAPI}';
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      final List<dynamic> jsonList = jsonDecode(response.body);
      List<BlogModel> blogs = [];

      blogs = jsonList.map((dynamic json) => BlogModel.fromJson(json as Map<String, dynamic>)).toList();
      return blogs;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
