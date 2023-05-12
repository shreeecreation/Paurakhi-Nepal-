import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/profile/model/edit_profile_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class EditProfile {
  static Future<http.Response?> editProfile(EditProfileModel editModel) async {
    final url = Uri.parse('${Environment.apiUrl}${AllAPIEndPoint.editProfileAPI}'); // Replace with your API endpoint URL
    final data = {'firstName': editModel.firstName, 'lastName': editModel.lastName, "address": editModel.address, "phoneNumber": editModel.phoneNo};
    try {
      final response = await http.put(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'}, // Replace with your headers if needed
      );
      var code = response.statusCode;
      if (code >= 200 && code < 300) {
        print(response.body);
        return response;
      } else if (code == 500) {}
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
