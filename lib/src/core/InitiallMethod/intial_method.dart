import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/AllBottomNavigator/login_true_bottom_navigation.dart';
import 'package:paurakhi/src/core/API/Notification%20API/in_app_notification.dart';
import 'package:paurakhi/src/core/API/Notification%20API/notification_api.dart';
import 'package:paurakhi/src/core/API/login/isverify.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/providers/language_provider.dart';

class IntialMethod {
  static void initialMethod() async {
    await LocalizationManager.getCurrentLocale();
    // Initialize the GetX controller
  Get.put(NotificationCountController());
    InAppNotification.initNotifications();
    await dotenv.load(fileName: Environment.fileName);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    await dotenv.load();
    //  await LocalizationManager.retrieveStoredLocale(); //
    await SSEManager.startListening();
    await IsVerify.checkVerified();
    GetUserInfo.getUserInfo();
  }
}
