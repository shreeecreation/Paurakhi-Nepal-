import 'package:flutter/material.dart';

import 'dropdown_api.dart';

class DropdownList {
  static Future<List<DropdownMenuItem<String>>> returnDropdown() async {
    List<DropdownMenuItem<String>> list = await DropDownAPI.dropdownAPI();
    return list;
  }
}
