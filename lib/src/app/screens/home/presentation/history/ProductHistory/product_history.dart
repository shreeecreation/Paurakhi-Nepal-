import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/ProductHistory/model/product_history_model.dart';
import 'package:paurakhi/src/core/API/ProductHistoryAPI/product_history_api.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductHistoryController extends GetxController {
  final RxList<Product> productHistoryList = <Product>[].obs;
  final RxBool isLoading = false.obs;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    fetchProductHistory();
  }

  Future<void> fetchProductHistory() async {
    if (!isLoading.value) {
      isLoading.value = true;
      final ProductHistoryModel? productHistory =
          await ProductHistory.productHistory(page);
      if (productHistory != null) {
        if (productHistory.data.isNotEmpty && productHistory.data.isNotEmpty) {
          productHistoryList.addAll(productHistory.data);
          page++; // Increment the page for the next API call
        }
      }
      isLoading.value = false;
    }
  }

  Future<void> loadProductHistory() async {
    page = 1;
    productHistoryList.clear();
    if (!isLoading.value) {
      isLoading.value = true;
      final ProductHistoryModel? productHistory =
          await ProductHistory.productHistory(1);
      if (productHistory != null && productHistory.data.isNotEmpty) {
        productHistoryList.addAll(productHistory.data);
      }
      isLoading.value = false;
    }
  }
}

void productHistoryScreen(BuildContext context) {
  final ProductHistoryController controller =
      Get.put(ProductHistoryController());

  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                      child: Text("Product History",
                          style: AppStyles.text22PxBold)),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Obx(
                    () {
                      if (controller.productHistoryList.isEmpty &&
                          controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      } else if (controller.productHistoryList.isEmpty) {
                        Get.find<ProductHistoryController>().isLoading.value =
                            false;

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 30),
                              const Icon(
                                Icons.info_rounded,
                                size: 60,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "No history found!",
                                style: AppStyles.text18PxMedium,
                              ),
                            ],
                          ),
                        );
                      } else {
                        final bool isLoadMoreVisible =
                            controller.productHistoryList.length > 9;
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    controller.productHistoryList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <
                                      controller.productHistoryList.length) {
                                    final Product datum =
                                        controller.productHistoryList[index];
                                    return historyWidget(
                                        datum.name,
                                        datum.status,
                                        datum.price,
                                        datum.quantity,
                                        context,
                                        datum);
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                            if (isLoadMoreVisible &&
                                !controller.isLoading.value)
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 40,
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.find<ProductHistoryController>()
                                            .page++;
                                        controller.fetchProductHistory();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.textGreen,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.load_more,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.find<ProductHistoryController>().page++;
                            //     controller.fetchProductHistory();
                            //   },
                            //   child: const Padding(
                            //     padding: EdgeInsets.all(16.0),
                            //     child: Text(
                            //       'Load More',
                            //       style: TextStyle(
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.blue),
                            //     ),
                            //   ),
                            // ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ));
    },
  );
}

SizedBox historyWidget(
    product, status, price, quantity, context, clickedProduct) {
  return SizedBox(
    height: 100,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$product", style: AppStyles.text20PxBold),
                      const SizedBox(height: 8),
                      Text("Quantity: $quantity", style: AppStyles.text14Px),
                      const SizedBox(height: 8),
                      Text("Price: $price", style: AppStyles.text14Px),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      status == "pending"
                          ? const Icon(Icons.check_circle_rounded,
                              size: 25, color: Colors.grey)
                          : status == "cancel"
                              ? const Icon(Icons.close_rounded,
                                  size: 25, color: Colors.red)
                              : status == "approved"
                                  ? const Icon(Icons.check_circle_rounded,
                                      size: 25, color: Colors.green)
                                  : const Icon(Icons.close_rounded,
                                      size: 25, color: Colors.red),
                      IconButton(
                        onPressed: () {
                          // ProductHistory.deleteProduct(page);
                          deleteComponent(context, clickedProduct);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.statusRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
