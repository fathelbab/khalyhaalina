import 'package:eshop/model/announcement_data.dart';
import 'package:flutter/foundation.dart';
import 'package:eshop/data/service/services.dart';

class AnnouncementProvider extends ChangeNotifier {
  List<AnnouncementData> _announcementList = [];
  fetchAnnouncementList() async {
    _announcementList = await fetchAnnouncement();
    notifyListeners();
  }

  List<AnnouncementData> get announcementList => _announcementList;
}
