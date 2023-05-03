import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';

class ManageLoginCookie {
  static void manageLoginCookieTwoFactorFalse(response) {
    var cookieHeader = response!.headers['set-cookie'];
    ManageCookie.setCookie(cookieHeader);
    HomeRoutes.homeScreen();
  }

  static void manageLoginCookieTwoFactorTrue(response) {
    var cookieHeader = response!.headers['set-cookie'];
    ManageCookie.setOTPCookie(cookieHeader);
    AuthRoutes.otpRoute("");
  }
}
