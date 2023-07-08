import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class InAppNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> initNotifications() async {
    // Initialization setting for android
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
 var initializationSettingsIoS =  DarwinInitializationSettings(requestAlertPermission: true,requestBadgePermission: true,requestSoundPermission: true, onDidReceiveLocalNotification: (id, title, body, payload) {
  
},);
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIoS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => debugPrint("details"),
    );
  }

  static void showInAppNotification(String title, String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
