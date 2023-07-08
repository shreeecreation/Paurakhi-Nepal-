import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/core/providers/language_provider.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:restart_app/restart_app.dart';

class LanguageDialog {
  static Future<dynamic> languageDialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 50,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    backgroundColor: Colors.white,
                    contentPadding: const EdgeInsets.all(16.0),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Text("Choose Language",
                              style: AppStyles.text20PxSemiBold,
                              textAlign: TextAlign.center),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: Get.find<CheckboxController>()
                                      .nepaliChecked
                                      .value,
                                  onChanged: (value) {
                                    Get.find<CheckboxController>()
                                        .setNepaliChecked(value!);
                                  },
                                  activeColor: Colors.green,
                                  shape: const CircleBorder(),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text("नेपाली"),
                              const SizedBox(width: 16),
                              Obx(
                                () => Checkbox(
                                  value: Get.find<CheckboxController>()
                                      .englishChecked
                                      .value,
                                  activeColor: Colors.green,
                                  onChanged: (value) {
                                    Get.find<CheckboxController>()
                                        .setEnglishChecked(value!);
                                  },
                                  shape: const CircleBorder(),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text("English"),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  elevation: 0),
                              onPressed: () async {
                                var englishChecked =
                                    Get.find<CheckboxController>()
                                        .englishChecked
                                        .value;
                                var nepaliChecked =
                                    Get.find<CheckboxController>()
                                        .nepaliChecked
                                        .value;
                                String language = "en";
                                if (nepaliChecked) {
                                  language = "ne";
                                }
                                if (englishChecked) {
                                  language = "en";
                                }
                                await LocalizationManager.setLanguageDialog(
                                    "done");
                                LocalizationManager.setCurrentLocale(
                                    Locale(language));
                                Restart.restartApp();
                              },
                              child: const Text("Select",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(Icons.info,
                          color: Colors.white, size: 59)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CheckboxController extends GetxController {
  RxBool nepaliChecked = false.obs;
  RxBool englishChecked = true.obs;

  void setNepaliChecked(bool value) {
    if (value) {
      nepaliChecked.value = true;
      englishChecked.value = false;
    }
  }

  void setEnglishChecked(bool value) {
    if (value) {
      englishChecked.value = true;
      nepaliChecked.value = false;
    }
  }
}
