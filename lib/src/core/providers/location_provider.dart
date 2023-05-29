import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/utils/get_current_location.dart';

class LocationProvider with ChangeNotifier {
  String _location = "";

  String get location => _location;

  void changeLocation(context) {
    _location = GetCurrentLocation.currentAddress ?? "";
    notifyListeners();
  }
}
