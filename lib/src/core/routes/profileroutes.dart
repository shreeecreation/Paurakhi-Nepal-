import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/financeenquirydesc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/profile/openticket/openticket_screen.dart';

class ProfileRoutes {
  static void openticketRoute() {
    Get.to(OpenTicket());
  }

  void editProfileRoute() {}
  void changepasswordRoute() {}
  void quotationhistoryRoute() {}

  static void financeenquiryRoute() {
    Get.to(const FinanceAction());
  }

  void logoutRoute() {}
}
