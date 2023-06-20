import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationManager {
  static const String _kLocaleKey = 'currentLocale';
  static String storedLocale = 'en';

  static Future<void> setCurrentLocale(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleKey, locale.languageCode);
  }

  static Future<String> getCurrentLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedLocales = prefs.getString(_kLocaleKey);

    if (storedLocales != null) {
      storedLocale = storedLocales;
      return storedLocales;
    } else {
      return 'en';
    }
  }
}
