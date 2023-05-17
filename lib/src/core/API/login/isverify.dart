import 'package:shared_preferences/shared_preferences.dart';

class IsVerify {
  static bool isVerify = false;
  static Future<bool> checkVerified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isVerify = prefs.getBool('verified') ?? false;
    return isVerify;
  }

  static setVerified(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('verified', value);
  }
}
