import 'dart:convert';

import 'package:http_parser/http_parser.dart' as parser;

import 'package:path/path.dart';

import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/model/product_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

class SellProductAPI {
  static Future<http.Response?> sellProduct(SellProductModel model) async {
    final requestModel = model;
    var cookie = await ManageCookie.getCookie();
// add files
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
      request.fields['type'] = 'sell';
      request.fields['description'] = model.description;
      request.fields['tag'] = model.tags;
      request.fields['category'] = model.category.toString();
      request.fields['quantity'] = model.quantity.toString();
      request.fields['price'] = model.price.toString();

      request.headers['cookie'] = cookie;
      var response = await request.send();

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
