import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

class GoogleAuthAPI {
  static Future<http.Response?> googleAuthAPI() async {
    final url = Uri.parse('${Environment.apiUrl}/auth/user/google'); // Replace with your API endpoint URL

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        return response;
      } else if (code == 400) {
      } else if (code == 500) {}
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
