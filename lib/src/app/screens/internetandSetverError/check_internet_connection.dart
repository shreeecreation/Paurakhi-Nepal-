import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class NetworkProvider extends ChangeNotifier {
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }
    notifyListeners();
  }
}
