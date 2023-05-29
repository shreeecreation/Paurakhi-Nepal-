import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paurakhi/src/core/API/login/isverify.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

class IntialMethod {
  static void initialMethod() async {
    await dotenv.load(fileName: Environment.fileName);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    await dotenv.load();
    await IsVerify.checkVerified();
    GetUserInfo.getUserInfo();
  }
}
