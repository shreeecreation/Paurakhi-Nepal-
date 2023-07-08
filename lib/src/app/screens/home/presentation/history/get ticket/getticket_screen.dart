import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/core/API/Get%20Ticket%20API/getticket_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'getticket_model.dart';

class TicketHistoryController extends GetxController {
  final RxList<Datums> quotationHistoryList = <Datums>[].obs;
  final RxBool isLoading = false.obs;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    fetchTicketHistory();
  }

  Future<void> fetchTicketHistory() async {
    if (!isLoading.value) {
      isLoading.value = true;
      final TicketHistoryModel? quotationHistory =
          await GetTicketHistory.ticketHistory(page);
      if (quotationHistory != null && quotationHistory.data.isNotEmpty) {
        quotationHistoryList.addAll(quotationHistory.data);
        page++; // Increment the page for the next API call
      }
      isLoading.value = false;
    }
  }

  Future<void> loadTicketHistory() async {
    page = 1;
    quotationHistoryList.clear();
    if (!isLoading.value) {
      isLoading.value = true;
      final TicketHistoryModel? quotationHistory =
          await GetTicketHistory.ticketHistory(1);
      if (quotationHistory != null && quotationHistory.data.isNotEmpty) {
        quotationHistoryList.addAll(quotationHistory.data);
      }
      isLoading.value = false;
    }
  }
}

void ticketHistoryScreen(BuildContext context) {
  final TicketHistoryController controller = Get.put(TicketHistoryController());

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
                      child: Text("Ticket History",
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
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    controller.quotationHistoryList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <
                                      controller.quotationHistoryList.length) {
                                    final Datums datum =
                                        controller.quotationHistoryList[index];
                                    return historyWidget(datum.title,
                                        datum.status, datum.createdAt);
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                            if (isLoadMoreVisible &&
                                !controller.isLoading.value)
                              GestureDetector(
                                onTap: () {
                                  Get.find<TicketHistoryController>().page++;

                                  controller.fetchTicketHistory();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'Load More',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
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

SizedBox historyWidget(product, status, price) {
  return SizedBox(
    height: 100,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.5,
      child: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            title: Text("$product", style: AppStyles.text20PxBold),
            trailing: status == "pending"
                ? const Icon(Icons.airplane_ticket,
                    size: 30, color: Colors.grey)
                : status == "closed"
                    ? const Icon(Icons.airplane_ticket,
                        size: 30, color: Colors.green)
                    : status == "unsolved"
                        ? const Icon(Icons.airplane_ticket,
                            size: 30, color: Color.fromARGB(255, 255, 0, 0))
                        : const Icon(Icons.airplane_ticket,
                            size: 30, color: Colors.red),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 4),
              Text("Date: $price"),
            ]),
          ),
        ],
      ),
    ),
  );
}
