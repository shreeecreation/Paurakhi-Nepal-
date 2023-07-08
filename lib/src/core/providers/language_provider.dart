import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/initial/language_permission.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationManager {
  static const String _kLocaleKey = 'currentLocale';
  static String storedLocale = 'en';

  static Future<void> setCurrentLocale(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleKey, locale.languageCode);
    storedLocale = locale.languageCode;
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

  static languageDialog(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedPrefs = prefs.getString("language_dialog" ?? "");
    if (storedPrefs == "" || storedPrefs == null) {
      LanguageDialog.languageDialog(context);
    } else {
      return;
    }
  }

  static setLanguageDialog(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language_dialog", value);
  }
}
