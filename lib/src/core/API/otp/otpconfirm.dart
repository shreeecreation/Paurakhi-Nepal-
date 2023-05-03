import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class ConfirmOTP {
  static void confirmOtp(otp) async {
    var cookie = await ManageCookie.getOTPCookie();

    final response = await http.get(
      Uri.parse('${Environment.apiUrl}/verify/login'),
      headers: {'Cookie': cookie, 'otp': otp}, // Replace with your headers if needed
    );
    print(response.body);
  }
}
