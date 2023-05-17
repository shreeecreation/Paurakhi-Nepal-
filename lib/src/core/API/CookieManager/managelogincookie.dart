import 'package:paurakhi/src/core/API/CheckLogin/check_login.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';

class ManageLoginCookie {
  static void manageLoginCookieTwoFactorFalse(response) async {
    var cookieHeader = response!.headers['set-cookie'];
    ManageCookie.setCookie(cookieHeader);
    CheckLogin.setLoginInValue(true);
    HomeRoutes.homeScreen();
  }

  static void manageLoginCookieTwoFactorTrue(response) {
    var cookieHeader = response!.headers['set-cookie'];
    ManageCookie.setOTPCookie(cookieHeader);
    AuthRoutes.otpRoute();
  }
}
