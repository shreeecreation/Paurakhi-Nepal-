import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/auth/register/PrivacyPolicyTermsAndConditions/privacy_policy_terms_conditions.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/blog_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/search/search_value.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/financeenquiry_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/grants_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/news_screen.dart';

class DrawerRoutes {
  static void blogRoute() {
    clearAllSearchValue();

    Get.to(const BlogScreen());

    scaffoldKey.currentState!.openEndDrawer();
  }

  static void homeRoute(context) {
    clearAllSearchValue();
    Navigator.pop(context);
  }

  static void newsRoute() {
    clearAllSearchValue();

    Get.to(const NewsScreen());

    scaffoldKey.currentState!.openEndDrawer();
  }

  static void grantsRoute() {
    clearAllSearchValue();

    Get.to(const GrantsScreen());

    scaffoldKey.currentState!.openEndDrawer();
  }

  static void categoryRoute() {}
  static void financeRoute() {
    clearAllSearchValue();

    Get.to(const FinanceScreen());

    scaffoldKey.currentState!.openEndDrawer();
  }

  static void privacyPolicy(context) {
    clearAllSearchValue();

    Get.to(() => const PrivacyPolicyTermsAndConditions(
          isPolicy: false,
        ));
  }

  static void termsAndConditions(context) {
    clearAllSearchValue();

    Get.to(() => const PrivacyPolicyTermsAndConditions(
          isPolicy: true,
        ));
  }
}
