import 'dart:typed_data';
import 'package:eshop/utils/constants.dart';
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
      {required String title, required String body, required String image}) {
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(Constants.imagePath + image),
      largeIcon: DrawableResourceAndroidBitmap('app_logo'),
      contentTitle: title,
      summaryText: body,
    );
    var android = AndroidNotificationDetails(
      "channelId",
      "channelName",
      "channelDescription",
      priority: Priority.high,
      autoCancel: true,
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
      "hello : $body",
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
}
