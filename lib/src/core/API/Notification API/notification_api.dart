import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:eventsource/eventsource.dart';
import 'package:paurakhi/src/app/screens/home/presentation/AllBottomNavigator/login_true_bottom_navigation.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

import 'in_app_notification.dart';
import 'model/notification_model.dart';

class SSEManager {
  static List<String> notificationList = [];
  static bool notificationHandled = false;

  static Future<void> startListening() async {
    var cookie = await ManageCookie.getCookie();
    final headers = {'Cookie': cookie};
    // ignore: unnecessary_null_comparison
    if (cookie == "" || cookie == null) {
      return;
    }
    while (true) {
      try {
        final eventSource = await EventSource.connect(
          Uri.parse("${Environment.apiUrl}/${AllAPIEndPoint.notificationAPI}"),
          headers: headers,
        );

        eventSource.asBroadcastStream().listen((Event event) {});

        eventSource.onMessage.listen((Event event) async {
          if (!notificationHandled) {
            final notification = event.data;
            Map<String, dynamic> notificationData = json.decode(notification!);
            String message = notificationData['message'];

            notificationList.add(notification);
            InAppNotification.showInAppNotification('Paurakhi', message);

            final notificationCountController = Get.find<NotificationCountController>();
            notificationCountController.incrementNotificationCount();
            notificationHandled = true; // Set the flag to true after handling the notification
          }
          await Future.delayed(const Duration(seconds: 5)); // Delay before reconnecting

          Future.delayed(const Duration(milliseconds: 500), () {
            notificationHandled = false; // Set the flag to true after handling the notification
          });
        });

        eventSource.onError.listen((Event event) {
          return;
        });
      } catch (error) {
        debugPrint('Error occurred during the EventSource connection: $error');
      }
    }
  }
}

class GetNotificationAPI {
  static Future<List<NotificationModel>> getNotification(int page) async {
    var cookie = await ManageCookie.getCookie();

    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/${AllAPIEndPoint.getnotificationAPI}?page=$page'),
        headers: {'Cookie': cookie},
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['data'];
        List<NotificationModel> notifications = jsonList.map((json) => NotificationModel.fromJson(json)).toList();
        return notifications;
      } else {
        throw Exception('Failed to fetch notifications. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }
}
