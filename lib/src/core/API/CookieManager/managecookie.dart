import 'package:shared_preferences/shared_preferences.dart';

class ManageCookie {
  static Future<void> setCookie(cookie) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookie', "token=$cookie");
  }

  static Future<String> getCookie() async {
    var prefs = await SharedPreferences.getInstance();
    print(prefs.getString('cookie'));
    return prefs.getString('cookie') ?? "";
  }

  static Future<void> setOTPCookie(cookie) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('otpcookie', "token=$cookie");
  }

  static Future<String> getOTPCookie() async {
    var prefs = await SharedPreferences.getInstance();
    print(prefs.getString('otpcookie'));
    return prefs.getString('otpcookie') ?? "";
  }
}
