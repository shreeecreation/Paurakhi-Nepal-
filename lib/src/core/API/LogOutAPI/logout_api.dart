import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutAPI {
  static Future<void> clearSharedPreferences() async {
    String keepPrefKey = "language_dialog";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> allKeys = prefs.getKeys().toList();

    for (String key in allKeys) {
      if (key != keepPrefKey) {
        await prefs.remove(key);
      }
    }
    AuthRoutes.loginRoute();
  }
}
