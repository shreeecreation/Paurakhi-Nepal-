import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

import 'dropdown.dart';

class DropDownAPI {
  static Future<List<DropdownMenuItem<String>>> dropdownAPI() async {
    var cookie = await ManageCookie.getCookie();
    List<DropdownMenuItem<String>> allCategory = [
      const DropdownMenuItem(value: '', child: Text('All')),
    ];

    final url = Uri.parse('${Environment.apiUrl}/category/get-category'); // Replace with your API endpoint URL
    try {
      final response = await http.get(url, headers: {
        'Cookie': cookie,
      });
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<dynamic> categories = responseMap['data'];

      var code = response.statusCode;
      if (code == 200) {
        for (var category in categories) {
          allCategory.add(
            DropdownMenuItem(
              value: category['id'].toString(),
              child: Text(category['name']),
            ),
          );
        }
        return allCategory;
      } else {}
    } catch (e) {}
    return allCategory;
  }

  static Future<List<DropdownMenuItem>> categoryAPI() async {
    var cookie = await ManageCookie.getCookie();
    List<DropdownMenuItem> allCategory = [
      const DropdownMenuItem(value: '', child: Text('All')),
    ];

    final url = Uri.parse('${Environment.apiUrl}/category/get-category'); // Replace with your API endpoint URL
    try {
      final response = await http.get(url, headers: {
        'Cookie': cookie,
      });
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<dynamic> categories = responseMap['data'];

      var code = response.statusCode;
      if (code == 200) {
        for (var category in categories) {
          if (!allCategory.contains(category['name'])) {
            allCategory.add(DropdownMenuItem(
              value: category['id'].toString(),
              child: Text(category['name']),
            ));
          }
        }
        DropdownList.allCategory = allCategory;
        return allCategory;
      } else {}
    } catch (e) {
      print(e);
    }
    return allCategory;
  }
}
