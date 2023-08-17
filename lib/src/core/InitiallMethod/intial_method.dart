import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/AllBottomNavigator/login_true_bottom_navigation.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/Finance%20Query%20History/financequery_history.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/Grant%20History/getgrant_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/ProductHistory/product_history.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/Quotation%20Hisotry/quotation_history_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/get%20ticket/getticket_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/notifications/notifications_screeen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/choosedunit.dart';
import 'package:paurakhi/src/core/API/Notification%20API/in_app_notification.dart';
import 'package:paurakhi/src/core/API/Notification%20API/notification_api.dart';
import 'package:paurakhi/src/core/API/PrivacyPolicyAndTermsAndConditionsAPI/privacypolicy_termsandconditions.dart';
import 'package:paurakhi/src/core/API/login/isverify.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/providers/language_provider.dart';

class IntialMethod {
  static void initialMethod() async {
    await LocalizationManager.getCurrentLocale();
    Get.put(NotificationCountController());
    await dotenv.load(fileName: Environment.fileName);
   
    await dotenv.load();
    await GetUserInfo.getUserInfo();
    InAppNotification.initNotifications();
    Get.put(QuotationHistoryController());
    Get.put(ChoosedUnitController());
    Get.put(FinanceQueryHistoryController());
    Get.put(NotificationController());
    Get.put(TicketHistoryController());
    Get.put(GrantHistoryController());
    Get.put(SearchController());
    Get.put(ProductHistoryController());
    PrivacyPolicyTermsAndConditionsAPI.privacyAPI();
    PrivacyPolicyTermsAndConditionsAPI.termsAPI();
    // Get.put(LoadMoreControllerGetX());

    await SSEManager.startListening();
    await IsVerify.checkVerified();
  }
}
