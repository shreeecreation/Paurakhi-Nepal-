import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eventsource/eventsource.dart';
import 'package:paurakhi/src/core/API/AllAPIEndPoint/all_api_endpoint.dart';
import 'package:paurakhi/src/core/API/CookieManager/managecookie.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

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

          // Add the notification to the list

          notificationList.add(notification ?? "abcd");

          print('New notification: $notification');
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
  static Future<void> getNotification() async {
    var cookie = await ManageCookie.getCookie();


    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/${AllAPIEndPoint.getnotificationAPI}'),
        headers: {'Cookie': cookie}, // Replace with your headers if needed
      );
      Map<String, dynamic> body = jsonDecode(response.body);
      print(body);
    } catch (e) {}
  }
}
