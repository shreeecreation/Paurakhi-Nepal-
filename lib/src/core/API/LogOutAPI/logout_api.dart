import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutAPI {
  static Future<void> clearSharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    AuthRoutes.loginRoute();
  }
}
