import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class GetUserInfo {
  static Future<void> getUserInfo() async {
    var cookie = await ManageCookie.getCookie();
    print(cookie);
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/user/get-profile'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );

      print(response.body);
    } catch (e) {
      print("Error");
    }
  }
}
