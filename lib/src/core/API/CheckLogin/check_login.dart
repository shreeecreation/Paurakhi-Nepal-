import 'package:shared_preferences/shared_preferences.dart';

class CheckLogin {
  static Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  static void setLoginInValue(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', value);
  }
}
 