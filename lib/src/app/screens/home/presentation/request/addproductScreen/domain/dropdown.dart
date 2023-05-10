import 'package:flutter/material.dart';

import 'dropdown_api.dart';

class DropdownList {
  static List<String> allCategory = [];
  static Future<List<DropdownMenuItem<String>>> returnDropdown() async {
    List<DropdownMenuItem<String>> list = await DropDownAPI.dropdownAPI();
    return list;
  }

  static Future<List<String>> returnCatergory() async {
    List<String> list = await DropDownAPI.categoryAPI();
    return list;
  }

  static List<String> returnCategoryOnly() {
    List<String> finalList = [];
    Future<List<String>> list = DropDownAPI.categoryAPI().then(
      (value) {
        finalList = value;
        allCategory = finalList;
        return finalList;
      },
    );
    return finalList;
  }
}
