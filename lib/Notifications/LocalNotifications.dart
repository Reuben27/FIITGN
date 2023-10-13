import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initializeSetting(BuildContext context) async {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse : (void route) async { });
  }

  static void display(RemoteMessage message) async {
    try {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'Notifications', 'Notifications channel',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
      var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);

      await notificationsPlugin.show(
        0,
        message.notification.title,
        message.notification.body,
        platformChannelSpecifics,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
