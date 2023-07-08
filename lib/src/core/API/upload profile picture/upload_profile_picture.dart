import 'package:paurakhi/src/app/screens/home/presentation/profile/choose_profile_screen.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart' as parser;

class UploadProfilePicture {
  static Future<http.Response?> upoadPicture(filePath, context) async {
    var cookie = await ManageCookie.getCookie();
    late List<int> imageBytes;

    imageBytes = await filePath!.readAsBytes(); // Read image as bytes
// add files
    try {
      final request = http.MultipartRequest(
        "PUT",
        Uri.parse('${Environment.apiUrl}/${AllAPIEndPoint.uploadProfile}'),
        // Replace with your headers if needed
      );
      request.headers['cookie'] = cookie;
      request.files.add(http.MultipartFile.fromBytes(
        'profile',
        imageBytes,
        filename: 'profile.jpg', // Set a filename for the image
        contentType: parser.MediaType('image', 'jpeg'),
      ));
      http.Response response =
          await http.Response.fromStream(await request.send());

      // print(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        successEditProfile(context);
      }
    } catch (e) {
      debugPrint("$e dsadasdasd");
    }
    return null;
  }
}
