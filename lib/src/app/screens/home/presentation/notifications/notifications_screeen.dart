import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/core/API/Notification%20API/get_time_ago.dart';
import 'package:paurakhi/src/core/API/Notification%20API/model/notification_model.dart';
import 'package:paurakhi/src/core/API/Notification%20API/notification_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultbackground,
      body: RefreshIndicator(
        onRefresh: controller.refreshNotifications,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Notifications",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.notifications.length + 1,
                      itemBuilder: (context, index) {
                        if (index == controller.notifications.length) {
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (controller.notifications.isEmpty) {
                              return SizedBox(
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.info,
                                        size: 100,
                                        color: Color.fromARGB(87, 76, 175, 79)),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Empty Notification!",
                                      style: AppStyles.text20PxSemiBold,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 40,
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: controller.loadNotifications,
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
                              );
                            }
                          }
                        } else {
                          NotificationModel notification =
                              controller.notifications[index];
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.defaultbackground,
                                ),
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          _buildLeadingWidget(
                                              notification.type),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    minVerticalPadding: 10,
                                    title: SizedBox(
                                      height: 30,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notification.type.capitalize!,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: Text(
                                        getTimeAgo(notification.createdAt),
                                        style: AppStyles.text12Px),
                                    subtitle: Text(notification.message,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF646464))),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Color.fromARGB(32, 0, 0, 0),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: controller.loadNotifications,
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
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  _buildLeadingWidget(type) {
    switch (type) {
      case "product":
        return Icons.production_quantity_limits_sharp;
      case "finance":
        return Icons.monetization_on;
      case "grant":
        return Icons.query_builder;
      case "ticket":
        return Icons.airplane_ticket;
      case "query":
        return Icons.format_quote_sharp;
    }
  }
}

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  var currentPage = 1;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    isLoading.value = true;

    try {
      List<NotificationModel> newNotifications =
          await GetNotificationAPI.getNotification(currentPage);
      notifications.addAll(newNotifications);
      currentPage++;
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNotifications() async {
    notifications.clear();
    currentPage = 1;
    await loadNotifications();
  }
}
