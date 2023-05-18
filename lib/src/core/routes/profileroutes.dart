import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/financeenquirydesc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/profile/openticket/openticket_screen.dart';

import '../../app/screens/home/presentation/profile/addgrant_screen.dart';

class ProfileRoutes {
  static void openticketRoute() {
    Get.to(OpenTicket());
  }

  static void addGrantRoute() {
    Get.to(AddGrant());
  }

  void quotationhistoryRoute() {}

  static void financeenquiryRoute() {
    Get.to(const FinanceAction());
  }

  void logoutRoute() {}
}
