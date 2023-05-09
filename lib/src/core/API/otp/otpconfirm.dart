import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/CheckLogin/check_login.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';

class ConfirmOTP {
  static void confirmOtp2FA(otp) async {
    var cookie = await ManageCookie.getOTPCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/login?otp=$otp'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        HomeRoutes.homeScreen();
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      print("Error");
    }
  }

  static void confirmOtpNumberVerify(otp) async {
    var cookie = await ManageCookie.getOTPCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/verify/login?otp=$otp'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        CheckLogin.setLoginInValue(true);
        HomeRoutes.homeScreen();
      } else if (code == 400) {
      } else if (code == 500) {}
    } catch (e) {
      print("Error");
    }
  }
}
