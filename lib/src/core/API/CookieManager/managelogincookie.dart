import 'package:paurakhi/src/core/API/CheckLogin/check_login.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';
import 'package:paurakhi/src/core/routes/is_logged_in.dart';

class ManageLoginCookie {
  static void manageLoginCookieTwoFactorFalse(response, checklogin) async {
    var cookieHeader = response!.headers['set-cookie'];
    ManageCookie.setCookie(cookieHeader);
    if (IsLoggedIn.keepLogin) {
      CheckLogin.setLoginInValue(true);
    } else {
      CheckLogin.setLoginInValue(false);
    }
    HomeRoutes.homeScreen();
  }

  static void manageLoginCookieTwoFactorTrue(response, checklogin) {
    var cookieHeader = response!.headers['set-cookie'];
    ManageCookie.setOTPCookie(cookieHeader);
    AuthRoutes.otpRoute(false);
  }
}

class ManageRegisterCookie {
  static String register_token = "";
}
