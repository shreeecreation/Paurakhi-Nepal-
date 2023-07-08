import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/description/singlepagedescription_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/home_page.dart';

class HomeRoutes {
  static void homeScreen() {
    Get.offAll(() => const HomePage());
  }

  static void singlePageScreen(models) {
    Get.to(SinglePageDescriptionScreen(model: models));
  }

  static void singlePageScreenBlog(models) {
    Get.to(SinglePageDescriptionScreenBlog(model: models));
  }

  static void singlePageScreenNews(models) {
    Get.to(SinglePageDescriptionScreenBlog(model: models));
  }

  static void singlePageScreenFinance(models) {
    Get.to(SinglePageDescriptionScreenFinance(model: models));
  }

  static void singlePageScreenGrants(models) {
    Get.to(SinglePageDescriptionScreenGrants(model: models));
  }
}
