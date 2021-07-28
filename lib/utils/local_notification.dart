import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  late FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  LocalNotification() {
    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    print(payload);
  }

  void showNotification({required String title, required String body}) {
    var android = AndroidNotificationDetails(
      "channelId",
      "channelName",
      "channelDescription",
      priority: Priority.high,
      autoCancel: true,
      largeIcon: const DrawableResourceAndroidBitmap('app_logo'),
      icon: 'app_logo',
      importance: Importance.max,
      ongoing: true,
      styleInformation: BigTextStyleInformation(''),
    );
    var ios = IOSNotificationDetails();
    var notificationPlatformDetails =
        NotificationDetails(android: android, iOS: ios);
    flutterNotificationPlugin.show(
      0,
      title,
      "hello : $body",
      notificationPlatformDetails,
      payload: "message sent",
    );
  }
}
