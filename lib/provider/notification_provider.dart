import 'package:eshop/model/notification_data.dart';
import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/services.dart';

class NotificationProvider extends ChangeNotifier {
  List<Notifications> _notificationList = [];
  fetchNotificationList() async {
    _notificationList = await fetchNotification();
    notifyListeners();
  }

  List<Notifications> get notificationList => _notificationList;
}
