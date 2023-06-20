import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en'); // Initial locale is English ('en')

  Locale get currentLocale => _currentLocale;

  void changeLocale(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}
