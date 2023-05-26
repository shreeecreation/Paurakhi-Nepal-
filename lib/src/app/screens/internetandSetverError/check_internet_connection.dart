import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
class NetworkProvider extends ChangeNotifier {
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
