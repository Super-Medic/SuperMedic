import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "1:585309393841:android:2940a96afa932465df6390",
    "슈퍼메딕",
    description: "SuperMedic channel", // description
    importance: Importance.max,
  );
  static void initialize(BuildContext context) async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: DarwinInitializationSettings());

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (route) async {
      Navigator.of(context).pushNamed(route as String);
    });
  }

  static void display(RemoteMessage message) async {
    try {
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      );
      if (message.notification != null && Platform.isAndroid) {
        await _notificationsPlugin.show(
          message.notification.hashCode,
          message.notification?.title,
          message.notification?.body,
          notificationDetails,
          payload: message.data["route"],
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
