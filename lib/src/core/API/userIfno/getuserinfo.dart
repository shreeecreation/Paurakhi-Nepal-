import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paurakhi/src/app/screens/home/presentation/profile/model/profile_model.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/API/login/isverify.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class GetUserInfo {
  static Future<void> getUserInfo() async {
    var cookie = await ManageCookie.getCookie();
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/user/get-profile'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      Map<String, dynamic> body = jsonDecode(response.body);
      var data = body['data'];

      ProfileModel.userId = data['userId'];
      ProfileModel.role = data['role'];
      ProfileModel.twoFactor = data['twoFactor'];
      ProfileModel.verified = data['verified'];
      ProfileModel.phoneNumber = data['phoneNumber'];
      if (ProfileModel.verified == true) {
        await IsVerify.setVerified(true);
      } else {
        await IsVerify.setVerified(false);
      }

      Map<String, dynamic> profileData = data['profile'];

      Profile.firstName = profileData['firstName'];
      Profile.lastName = profileData['lastName'];
      Profile.email = profileData['email'];
      Profile.address = profileData['address'];
      Profile.picture = profileData['picture'];
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
