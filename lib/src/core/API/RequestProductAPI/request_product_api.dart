import 'dart:convert';
import 'package:path/path.dart';

import 'package:paurakhi/src/app/screens/home/presentation/request/requestProductScreen/model/requestproduct_model.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http_parser/http_parser.dart' as parser;

class RequestProductAPI {
  static Future<http.Response?> sellProduct(RequestProductModel model) async {
    var cookie = await ManageCookie.getCookie();
    print(model.toMap());
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.createCategory}'),
        // Replace with your headers if needed
      );
      for (int i = 0; i < model.image.length; i++) {
        var file = model.image[i];
        var stream = file.openRead().cast<List<int>>(); // cast the stream to a Stream<List<int>>
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'images',
          stream,
          length,
          filename: basename(file.path),
          contentType: parser.MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }
      request.fields['name'] = model.name;
      request.fields['type'] = 'request';
      request.fields['description'] = model.description;
      request.fields['category'] = model.category.toString();
      request.fields['quantity'] = model.quantity.toString();
      request.fields['price'] = model.price.toString();

      request.headers['cookie'] = cookie;
      var response = await request.send();
      print(response.statusCode);
      print(response.stream.bytesToString());
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString(); // read the response body as a string
        var decodedResponse = jsonDecode(responseBody); // decode the response body from JSON if necessary
        print('Success! Response body: $decodedResponse');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
