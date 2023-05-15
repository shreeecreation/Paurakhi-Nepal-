import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class InternetConnectionProvider extends ChangeNotifier {
  bool _isConnected = false;

  InternetConnectionProvider() {
    Timer.periodic(const Duration(seconds: 1), (_) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _isConnected = false;
      } else {
        _isConnected = true;
      }
      notifyListeners();
    });
  }

  bool get isConnected => _isConnected;
}
