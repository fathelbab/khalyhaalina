import 'dart:typed_data';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/log.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:ui';

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

  void showNotification(
      {required String title,
      required String body,
      required String image}) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
        await _getByteArrayFromUrl("${Constants.imagePath}$image"));
    Log.d(image);
    var bigPictureStyleInformation = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('app_logo'),
      largeIcon: DrawableResourceAndroidBitmap('app_logo'),
      contentTitle: title,
      summaryText: body,
      htmlFormatContentTitle: true,
      htmlFormatSummaryText: true,
    );
    var android = AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Notifications",
      "This channel is used for important notifications.",
      priority: Priority.high,
      autoCancel: true,
      icon: 'app_logo',
      largeIcon: const DrawableResourceAndroidBitmap('app_logo'),
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      ongoing: true,
    );
    var ios = IOSNotificationDetails();
    var notificationPlatformDetails =
        NotificationDetails(android: android, iOS: ios);
    flutterNotificationPlugin.show(
      0,
      title,
      "$body",
      notificationPlatformDetails,
      payload: "message sent",
    );
  }

  // Future<void> _showBigPictureNotificationURL() async {
  //   var bigPicture = ByteArrayAndroidBitmap(
  //       await _getByteArrayFromUrl('https://via.placeholder.com/400x800'));

  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(bigPicture,
  //           largeIcon: bigPicture,
  //           contentTitle: 'overridden <b>big</b> content title',
  //           htmlFormatContentTitle: true,
  //           summaryText: 'summary <i>text</i>',
  //           htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails('big text channel id',
  //           'big text channel name', 'big text channel description',
  //           styleInformation: bigPictureStyleInformation);
  //   final NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   flutterNotificationPlugin.show(
  //       0, 'big text title', 'silent body', platformChannelSpecifics);
  // }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
