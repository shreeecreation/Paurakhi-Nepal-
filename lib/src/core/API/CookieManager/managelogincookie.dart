import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';

class ManageLoginCookie {
  static String? extractTokenFromCookie(String cookieHeader) {
    var cookies = cookieHeader.split('; ');

    // Find the cookie with the name 'token'
    var tokenCookie = cookies.firstWhere(
      (cookie) => cookie.startsWith('token='),
      orElse: () => "",
    );

    // Extract the token value from the cookie
    var token = tokenCookie.substring(6);

    return token;
  }

  static void manageLoginCookieTwoFactorFalse(response) {
    var cookieHeader = response!.headers['set-cookie'];
    var token = extractTokenFromCookie(cookieHeader!);
    ManageCookie.setCookie(token);
    HomeRoutes.homeScreen();
  }

  static void manageLoginCookieTwoFactorTrue(response) {
    var cookieHeader = response!.headers['set-cookie'];
    var token = extractTokenFromCookie(cookieHeader!);
    ManageCookie.setOTPCookie(token);
    AuthRoutes.otpRoute("");
  }
}
