import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eventsource/eventsource.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

import 'in_app_notification.dart';
import 'model/notification_model.dart';

class SSEManager {
  static List<String> notificationList = [];
  static Future<void> startListening() async {
    var cookie = await ManageCookie.getCookie();
    final headers = {'Cookie': cookie};

    while (true) {
      try {
        final eventSource = await EventSource.connect(
          Uri.parse("${Environment.apiUrl}/${AllAPIEndPoint.notificationAPI}"),
          headers: headers,
        );

        eventSource.asBroadcastStream().listen((Event event) {
          print("EventSource connection opened");
        });

        eventSource.onMessage.listen((Event event) {
          print("Start listening");
          final notification = event.data;
          print(notification);
          Map<String, dynamic> notificationData = json.decode(notification!);

// Extract the value of the "message" key
          String message = notificationData['message'];
          // Add the notification to the list

          notificationList.add(notification ?? "abcd");
          InAppNotification.showInAppNotification('Paurakhi', message ?? "");
        });

        eventSource.onError.listen((Event event) {
          print('Error: $event');
        });

        await Future.delayed(const Duration(seconds: 5)); // Delay before reconnecting
      } catch (error) {
        print('Error occurred during the EventSource connection: $error');
        await Future.delayed(const Duration(seconds: 5)); // Delay before reconnecting
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
