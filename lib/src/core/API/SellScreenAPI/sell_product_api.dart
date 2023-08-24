import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart' as parser;

import 'package:path/path.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/addtag.dart';

import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/model/product_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

class SellProductAPI {
  static Future<http.Response?> sellProduct(
      SellProductModel model, context) async {
    var cookie = await ManageCookie.getCookie();
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.createCategory}'),
        // Replace with your headers if needed
      );
      for (int i = 0; i < model.image.length; i++) {
        var file = model.image[i];
        var stream = file
            .openRead()
            .cast<List<int>>(); // cast the stream to a Stream<List<int>>
        var length = await file.length();
        var multipartFile = http.MultipartFile('images', stream, length,
            filename: basename(file.path),
            contentType: parser.MediaType('image', 'jpeg'));
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
        TagGenerator.tags.clear();
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        var message = jsonResponse['message'];
        WidgetsBinding.instance.addPostFrameCallback((_) {
          LoginDialogs.productCreated(context, message, "Success");
        });
      } else if (response.statusCode == 400) {
        var result = await response.stream.bytesToString();

        var decodedResult = json.decode(result);
        var message = decodedResult["message"];
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          LoginDialogs.productError(context, message);
        });
      }
    } catch (e) {}
    return null;
  }
}
