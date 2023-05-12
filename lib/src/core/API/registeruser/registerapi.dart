import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart' as parser;

import 'package:paurakhi/src/app/screens/auth/register/domain/model.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class RegisterAPI {
  static Future<http.Response?> registerAPI(RegisterModel model) async {
    final url = Uri.parse('${Environment.apiUrl}/auth/user/register'); // Replace with your API endpoint URL
    var cookie = await ManageCookie.getCookie();

    List<int> imageBytes = File(model.image!.path).readAsBytesSync();
    final dataSample = {
      'phoneNumber': model.phoneNo,
      'password': model.password,
      "address": model.address,
      "firstName": model.firstName,
      "lastName": model.lastName
    };
    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['firstName'] = model.firstName;
      request.fields['lastName'] = model.lastName;
      request.fields['address'] = model.address;
      request.fields['phoneNumber'] = model.phoneNo;
      request.fields['password'] = model.password;
      request.fields['email'] = model.email;
      request.headers['cookie'] = cookie;
      request.files.add(http.MultipartFile.fromBytes(
        'profile',
        imageBytes,
        filename: model.image!.path.split('/').last,
        contentType: parser.MediaType('image', 'jpeg'),
      ));
      http.Response response = await http.Response.fromStream(await request.send());
      var code = response.statusCode;
      print(response.body);
      print(code);
      if (response.statusCode == 200) {
        // print('Photo uploaded successfully!');
        return response;
      } else {
        print('Error uploading photo: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      print(e);
      print("Error wau ");
    }
    return null;
  }
}
