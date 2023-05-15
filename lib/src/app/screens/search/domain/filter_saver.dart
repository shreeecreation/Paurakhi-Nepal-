import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FilterSaver {
  static void saveFilter(category, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String numbersJson = jsonEncode(category);
    prefs.setString('filterCategory', numbersJson);
    prefs.setInt('type', type);
  }

  static getFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? numbersJson = prefs.getString('filterCategory');
    int? typeJson = prefs.getInt('type');
    if (numbersJson != null) {
      dynamic decoded = jsonDecode(numbersJson);
      if (decoded is List) {
        List<int> numbers = decoded.map((e) => int.parse(e.toString())).toList();
        Filter.filter = numbers;
      }
    }
    Filter.type = typeJson ?? 0;
  }
}

class Filter {
  static int type = 0;
  static List<int> filter = [];
}
