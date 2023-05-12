import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FilterSaver {
  static void saveFilter(category, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String numbersJson = jsonEncode(category);
    prefs.setString('filterCategory', numbersJson);
    prefs.setInt('type', type);
  }

  static Future<Filter> getFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? numbersJson = prefs.getString('filterCategory');
    int? typeJson = prefs.getInt('type');
    Filter filters = Filter();
    if (numbersJson != null) {
      dynamic decoded = jsonDecode(numbersJson);
      if (decoded is List) {
        List<int> numbers = decoded.map((e) => int.parse(e.toString())).toList();
        filters.filter = numbers;
      }
    }
    filters.type = typeJson ?? 0;
    return filters;
  }
}

class Filter {
  int type = 0;
  List<int> filter = [];
}
