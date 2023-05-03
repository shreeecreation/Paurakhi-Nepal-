import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/home_page.dart';

class HomeRoutes {
  static void homeScreen() {
    Get.offAll(const HomePage());
  }
}
