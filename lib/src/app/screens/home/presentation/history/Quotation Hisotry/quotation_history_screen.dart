import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/core/API/Quotation%20Historu%20API/quotation_history_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model/quotationhistory_model.dart';

class QuotationHistoryController extends GetxController {
  final RxList<Datum> quotationHistoryList = <Datum>[].obs;
  final RxBool isLoading = false.obs;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    fetchQuotationHistory();
  }

  Future<void> fetchQuotationHistory() async {
    if (!isLoading.value) {
      isLoading.value = true;
      final QuotationHistoryModel? quotationHistory =
          await QuotationHistory.quotationHistory(page);
      if (quotationHistory != null && quotationHistory.data.isNotEmpty) {
        quotationHistoryList.addAll(quotationHistory.data);
        page++; // Increment the page for the next API call
      }
      isLoading.value = false;
    }
  }

  Future<void> loadQuotationHistory() async {
    page = 1;
    quotationHistoryList.clear();
    if (!isLoading.value) {
      isLoading.value = true;
      final QuotationHistoryModel? quotationHistory =
          await QuotationHistory.quotationHistory(1);
      if (quotationHistory != null && quotationHistory.data.isNotEmpty) {
        quotationHistoryList.addAll(quotationHistory.data);
      }
      isLoading.value = false;
    }
  }
}

void quotationHistoryScreen(BuildContext context) {
  final QuotationHistoryController controller =
      Get.put(QuotationHistoryController());

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
                      child: Text("Quotation History",
                          style: AppStyles.text22PxBold)),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Obx(
                    () {
                      if (controller.quotationHistoryList.isEmpty &&
                          controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      } else if (controller.quotationHistoryList.isEmpty) {
                        Get.find<QuotationHistoryController>().isLoading.value =
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
                            controller.quotationHistoryList.length > 9;
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    controller.quotationHistoryList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <
                                      controller.quotationHistoryList.length) {
                                    final Datum datum =
                                        controller.quotationHistoryList[index];
                                    return historyWidget(
                                        datum.product.name,
                                        datum.status,
                                        datum.price,
                                        datum.queryId);
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
                                        Get.find<QuotationHistoryController>()
                                            .page++;
                                        controller.fetchQuotationHistory();
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

SizedBox historyWidget(product, status, price, queryId) {
  return SizedBox(
    height: 120,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.5,
      child: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            title: Text("$product", style: AppStyles.text20PxBold),
            trailing: status == "pending"
                ? const Icon(Icons.check_circle_rounded,
                    size: 30, color: Colors.grey)
                : status == "cancel"
                    ? const Icon(Icons.close_rounded,
                        size: 30, color: Colors.red)
                    : status == "approved"
                        ? const Icon(Icons.check_circle_rounded,
                            size: 30, color: Colors.green)
                        : const Icon(Icons.close_rounded,
                            size: 30, color: Colors.red),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text("Query Id: $queryId"),
                const SizedBox(height: 8),
                Text("Price: $price"),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
