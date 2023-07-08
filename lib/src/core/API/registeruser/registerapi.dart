import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as parser;
import 'package:paurakhi/src/app/screens/auth/register/domain/model.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/API/CookieManager/managelogincookie.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';

class RegisterAPI {
  static Future<http.Response?> registerAPI(
      RegisterModel model, context) async {
    final url = Uri.parse(
        '${Environment.apiUrl}/auth/user/register'); // Replace with your API endpoint URL
    var cookie = await ManageCookie.getCookie();
    late List<int> imageBytes;
    if (model.image == null || model.image == "") {
      ByteData defaultImageData =
          await rootBundle.load('assets/images/defaultImage.jpg');
      imageBytes = defaultImageData.buffer.asUint8List();
    } else {
      imageBytes = await model.image!.readAsBytes(); // Read image as bytes
    }

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
        filename: 'profile.jpg', // Set a filename for the image
        contentType: parser.MediaType('image', 'jpeg'),
      ));
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        var cookieHeader = response.headers['set-cookie'];
        ManageRegisterCookie.register_token = cookieHeader ?? "";
        AuthRoutes.otpRouteVerify();
        // print('Photo uploaded successfully!');
        return response;
      } else if (response.statusCode == 400) {
        var result = json.decode(response.body);
        var message = result["message"];
        LoginDialogs.loginError(context, message);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          UserDialogs.internalServerError(context);
        });
      }
      return null;
    } catch (e) {}
    return null;
  }
}
