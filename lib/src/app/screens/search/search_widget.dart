import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/app/screens/search/search_dialog.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';
import 'package:paurakhi/src/core/utils/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'domain/filter_saver.dart';
import 'domain/search_value.dart';

class SearchControllerHome extends GetxController {
  String type = "sell";
  var productList = <ProductModel>[].obs;

  int currentPage = 1;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    Filter.type == 0 ? type = "request" : type = "sell";
    loadProducts(true);
  }

  Future<void> loadProducts(shouldUpdate) async {
    shouldUpdate ? null : productList.clear();
    Filter.type == 0 ? type = "request" : type = "sell";
    shouldUpdate ? currentPage = currentPage : currentPage = 1;

    if (!isLoading.value) {
      isLoading.value = true;
      final response = await SearchAPI.getSearchedProduct(
        SearchValue.searchValue,
        type,
        Get.context!,
        currentPage,
      );

      if (response != null) {
        productList.addAll(response.data);
        shouldUpdate ? currentPage++ : currentPage = 1;
      }

      isLoading.value = false;
    }
  }

  Future<void> refreshProducts() async {
    productList.clear();
    currentPage = 1;
    await loadProducts(false);
  }
}

class SearchWidget extends GetView<SearchControllerHome> {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SearchValue.searchValue = "";
        return false;
      },
      child: RefreshIndicator(
        onRefresh: controller.refreshProducts,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Search results for "${SearchValue.searchValue == "" ? "ALL" : SearchValue.searchValue}"\n for type ${controller.type}',
                    textAlign: TextAlign.center,
                    style: AppStyles.text16PxMedium,
                  ),
                  const SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: () {
                      showOptionsDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.green,
                    ),
                    child: const Row(
                      children: [
                        Text("Filter"),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            Obx(
              () => ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.productList.length,
                itemBuilder: (BuildContext context, int index) {
                  final ProductModel datum = controller.productList[index];
                  return everyProductWidgetProduct(context, datum);
                },
              ),
            ),
            Obx(() => controller.productList.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Text("No product found !",
                          style: AppStyles.text18PxMedium),
                    ],
                  ))
                : const Text("")),
            Obx(
              () => controller.productList.length > 9
                  ? controller.isLoading.value
                      ? loadingIndicator(context)
                      : Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SizedBox(
                            height: 40,
                            width: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.find<SearchControllerHome>().currentPage++;
                                controller.loadProducts(true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.isLoading.value
                                    ? Colors.grey
                                    : AppColors.textGreen,
                              ),
                              child: Text(controller.isLoading.value
                                  ? AppLocalizations.of(context)!.loading
                                  : AppLocalizations.of(context)!.load_more),
                            ),
                          ),
                        )
                  : const Text(""),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
