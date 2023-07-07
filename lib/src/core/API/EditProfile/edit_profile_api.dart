import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/profile/model/edit_profile_model.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class EditProfile {
  static Future<http.Response?> editProfile(
      EditProfileModel editModel, context) async {
    final url = Uri.parse(
        '${Environment.apiUrl}${AllAPIEndPoint.editProfileAPI}'); // Replace with your API endpoint URL
    final data = {
      'firstName': editModel.firstName,
      'lastName': editModel.lastName,
      "address": editModel.address,
      "twoFactor": editModel.twoFactor
    };
    var cookie = await ManageCookie.getCookie();

    try {
      final response = await http.put(
        url,

        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookie
        }, // Replace with your headers if needed
      );
      var code = response.statusCode;
      var result = json.decode(response.body);
      var message = result["message"];
      if (code >= 200 && code < 300) {
        UserDialogs.updateProfile(
            context, message, Icons.check_circle, "Success");

        await GetUserInfo.getUserInfo();
        return response;
      } else if (code == 500) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          UserDialogs.internalServerError(context);
        });
      } else {
        UserDialogs.updateProfile(context, message, Icons.close, "Success");
      }
      return null;
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
