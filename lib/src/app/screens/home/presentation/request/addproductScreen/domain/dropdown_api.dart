import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/choosedunit.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/model/dropdown_model.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

import 'dropdown.dart';

class DropDownAPI {
  static var items;
  static Future<List<DropdownMenuItem<String>>> dropdownAPI() async {
    var cookie = await ManageCookie.getCookie();
    List<DropdownMenuItem<String>> allCategory = [
      const DropdownMenuItem(value: '', child: Text('All')),
    ];

    final url = Uri.parse('${Environment.apiUrl}/category/get-category');
    try {
      final response = await http.get(url, headers: {
        'Cookie': cookie,
      });
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<dynamic> categories = responseMap['data'];

      var code = response.statusCode;
      if (code == 200) {
        var categoryValues = <String>{};
        for (var category in categories) {
          var categoryId = category['id'].toString();
          // Skip categories with duplicate values
          if (!categoryValues.contains(categoryId)) {
            allCategory.add(
              DropdownMenuItem(
                value: categoryId,
                child: Text(category['name']),
              ),
            );
            categoryValues.add(categoryId);
          }
        }
        List<CategoryModel> categoryItems = categories.map((category) => CategoryModel.fromJson(category as Map<String, dynamic>)).toList();
        items = DropdownModel(data: categoryItems);
        ChoosedUnitController chooseUnitController = Get.find<ChoosedUnitController>();

        chooseUnitController.changeunit();

        return allCategory;
      } else {
        // Handle the case when the response code is not 200
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
    }
    return allCategory;
  }

  static Future<DropdownModel> unitAPI() async {
    var cookie = await ManageCookie.getCookie();

    final url = Uri.parse('${Environment.apiUrl}/category/get-category');
    try {
      final response = await http.get(url, headers: {
        'Cookie': cookie,
      });
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<dynamic> categories = responseMap['data'];

      var code = response.statusCode;
      if (code == 200) {
        var categoryValues = <String>{};
        for (var category in categories) {
          var categoryId = category['id'].toString();
          // Skip categories with duplicate values
          if (!categoryValues.contains(categoryId)) {
            categoryValues.add(categoryId);
          }
        }
        print(response.body);
        List<CategoryModel> categoryItems = categories.map((category) => CategoryModel.fromJson(category as Map<String, dynamic>)).toList();
        DropdownModel dropdownModel = DropdownModel(data: categoryItems);
        print(dropdownModel);
        return dropdownModel;
      } else {
        // Handle the case when the response code is not 200
      }
    } catch (e) {
      print(e);
      // Handle any exceptions that occur during the API call
    }
    return DropdownModel(data: []);
  }

  static Future<List<DropdownMenuItem>> categoryAPI() async {
    var cookie = await ManageCookie.getCookie();
    List<DropdownMenuItem> allCategory = [
      const DropdownMenuItem(value: 'all', child: Text('All')),
    ];

    final url = Uri.parse('${Environment.apiUrl}/category/get-category');
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
