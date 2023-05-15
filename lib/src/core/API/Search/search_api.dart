import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

class SearchAPI {
  static Future<http.Response?> searchAPI(String name) async {
    final url = Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.searchAPI}name=$name'); // Replace with your API endpoint URL

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        print(response.body);
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
