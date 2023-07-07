import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicyTermsAndConditionsAPI {
  static String privacy = "";
  static String terms = "";
  static void privacyAPI({context}) async {
    String policyUrl = "${Environment.apiUrl}${AllAPIEndPoint.policy}";

    final url = policyUrl ;
    try {
      var response = await http.get(Uri.parse(url));

      var statusCode = response.statusCode;
      if (statusCode == 200) {
        var result = json.decode(response.body);
        var message = result["data"];
        privacy = message;
        debugPrint(response.body);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          UserDialogs.internalServerError(context);
        });
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

 static void termsAPI({context}) async {
    String termsUrl =
        "${Environment.apiUrl}${AllAPIEndPoint.termsAndCondition}";
    final url = termsUrl;
    try {
      var response = await http.get(Uri.parse(url));

      var statusCode = response.statusCode;

      if (statusCode == 200) {
        var result = json.decode(response.body);
        var message = result["data"];
        terms = message;
        debugPrint(response.body);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          UserDialogs.internalServerError(context);
        });
      }
    } catch (e) {
      debugPrint("$e");
    }
  }


}
